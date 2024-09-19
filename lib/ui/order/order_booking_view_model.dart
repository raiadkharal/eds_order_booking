import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_booking/db/entities/order/order.dart';
import 'package:order_booking/db/entities/order_detail/order_detail.dart';
import 'package:order_booking/db/entities/order_quantity/order_quantity.dart';
import 'package:order_booking/db/entities/packages/package.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/db/entities/product_group/product_group.dart';
import 'package:order_booking/model/order_detail_model/order_detail_model.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';
import 'package:order_booking/model/outlet_model/outlet_model.dart';
import 'package:order_booking/model/unit_price_breakdown_model/unit_price_breakdown_model.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/order/order_booking_repository.dart';
import 'package:order_booking/ui/order/pricing/pricing_manager.dart';
import 'package:order_booking/utils/Constants.dart';
import 'package:order_booking/utils/PreferenceUtil.dart';
import 'package:order_booking/utils/util.dart';
import 'package:order_booking/utils/utils.dart';

import '../../db/entities/available_stock/available_stock.dart';
import '../../db/entities/outlet/outlet.dart';
import '../../model/order_model/order_model.dart';
import '../../model/order_response_model/order_response_model.dart';
import '../../model/packageModel/package_model.dart';
import '../../utils/enums.dart';
import 'order_manager.dart';

class OrderBookingViewModel extends GetxController {
  final OrderBookingRepository _repository;
  final StatusRepository _statusRepository;
  final PreferenceUtil _preferenceUtil;

  final RxList<Package> _packages = RxList<Package>();
  final RxList<Product> filteredProducts = RxList<Product>();
  final RxList<ProductGroup> _productGroupList = RxList<ProductGroup>();
  final RxList<Product> _mutableProductList = RxList<Product>();
  final RxBool _isSaving = false.obs;
  final RxBool _noOrder = false.obs;
  final RxBool _orderSaved = false.obs;
  final Rx<String> _msg = "".obs;

  final Map<int?, TextEditingController> avlStockControllers = {};
  final Map<int?, TextEditingController> orderQtyControllers = {};

  OrderEntityModel? _order;
  Outlet? outlet;
  Package? package;
  List<AvailableStock>? _availableStockItems;
  int? _outletId;
  int? _distributionId;

  OrderBookingViewModel(
      this._repository, this._statusRepository, this._preferenceUtil);

  Future<void> init() async {
    _packages(await _repository.findAllPackages());
    _productGroupList(await _repository.findAllGroups());
    _distributionId = _preferenceUtil.getDistributionId();
    package = _packages.first;
    filterProductsByPackage(_packages.first.packageId);
    initializeControllers();
  }

  //not used
  Future<void> setOutletId(int outletId) async {
    _outletId = outletId;
    findOrder(outletId);

    //Add saved available stock item in List
    _availableStockItems?.clear();
    Outlet outlet = await _statusRepository.findOutletById(outletId);
    _availableStockItems = outlet.avlStockDetail;
    if (_availableStockItems != null) {
      // Log.d(TAG, availableStockItems.toString());
    }
  }

  void findOrder(int outletId) async {
    OrderEntityModel? orderModel = await _repository.findOrder(outletId);

    setOrder(orderModel);
  }

  void initializeControllers() async {
    List<OrderAndAvailableQuantity> orderQuantityList =
        await getOrderAndAvailableQuantityDataByOutlet(_outletId);

    List<Product> products = await getAllProducts();
    for (Product product in products) {
      OrderAndAvailableQuantity? orderQuantity =
          getOrderQuantityByProduct(orderQuantityList, product.id);

      avlStockControllers[product.id] = TextEditingController(
          text: Util.convertStockToNullableDecimalQuantity(
              orderQuantity?.avlCartonQuantity,
              orderQuantity?.avlUnitQuantity));
      orderQtyControllers[product.id] = TextEditingController(
          text: Util.convertStockToNullableDecimalQuantity(
              orderQuantity?.cartonQuantity, orderQuantity?.unitQuantity));
    }
  }

  Future<void> filterProductsByPackage(int? packageId) async {
    if (packageId == null) {
      return;
    }

    final allProductsByPackage =
        _repository.findAllProductsByPackage(packageId);

    if (_order == null) {
      allProductsByPackage.then(
        (products) {
          onProductsLoaded(products, packageId);
        },
      ).onError(
        (error, stackTrace) {
          showToastMessage(error.toString());
        },
      );
      return;
    }

    final List<OrderDetail> allAddedProducts =
        await _repository.getOrderItems(_order?.order?.id);

    Future<List<Product>> zippedSingleSource;

    if (_availableStockItems != null && _availableStockItems!.isNotEmpty) {
      zippedSingleSource = updateProducts(
          _availableStockItems, await allProductsByPackage, allAddedProducts);
    } else {
      zippedSingleSource = updateProductsWithoutAvailableStock(
          await allProductsByPackage, allAddedProducts);
    }

    zippedSingleSource
        .then(
      (products) => onProductsLoaded(products, packageId),
    )
        .onError(
      (error, stackTrace) {
        showToastMessage(error.toString());
      },
    );
  }

  Future<List<Product>> updateProducts(
      List<AvailableStock>? availableStockItems,
      List<Product> filteredProducts,
      List<OrderDetail> addedProducts) async {
    for (Product product in filteredProducts) {
      for (OrderDetail orderDetail in addedProducts) {
        if (product.id == orderDetail.mProductId) {
          product.setQty(
              orderDetail.mCartonQuantity, orderDetail.mUnitQuantity);
          product.setAvlStock(
              orderDetail.avlCartonQuantity, orderDetail.avlUnitQuantity);
        }
      }

      if (availableStockItems != null) {
        for (AvailableStock availableStock in availableStockItems) {
          if (product.id == availableStock.productId) {
            product.setAvlStock(
                availableStock.cartonQuantity, availableStock.unitQuantity);
          }
        }
      }
    }

    return filteredProducts;
  }

  Future<List<Product>> updateProductsWithoutAvailableStock(
      List<Product> filteredProducts, List<OrderDetail> addedProducts) async {
    for (Product product in filteredProducts) {
      for (OrderDetail orderDetail in addedProducts) {
        if (product.id == orderDetail.mProductId) {
          product.setQty(
              orderDetail.mCartonQuantity, orderDetail.mUnitQuantity);
          product.setAvlStock(
              orderDetail.avlCartonQuantity, orderDetail.avlUnitQuantity);
        }
      }
    }

    return filteredProducts;
  }

  void onProductsLoaded(List<Product> products, int? packageId) async {
    if (products.isEmpty) {
      products = await _repository.findAllProductsByPackage(packageId);
    }

    // Log.d("PackageId", products.size() + "After Size");

    _mutableProductList(products);
    setIsSaving(false);
  }

  Future<void> addOrder(
      List<Product> orderItems, int? packageId, bool sendToServer) async {
    if (_order == null) {
      OrderModel order = OrderModel(outletId: _outletId);
      _repository
          .createOrder(order)
          .whenComplete(() => addOrderItems(orderItems, sendToServer));
    } else {
//                repository.deleteOrderItemsByGroup(order.getOrder().getLocalOrderId(),groupId);
      _repository
          .deleteOrderItemsByPackage(_order?.order?.id, packageId)
          .whenComplete(() => addOrderItems(orderItems, sendToServer))
          .onError(
        (error, stackTrace) {
          showToastMessage(error.toString());
        },
      );
    }
  }

  void addOrderItems(List<Product> orderItems, bool sendToServer) {
    _repository
        .findOrder(_outletId)
        .then(
          (orderModel) => modifyOrderDetails(orderModel, orderItems),
        )
        .then(
          (value) => _repository.findOrder(_outletId),
        )
        .then(
          (orderModel) => onInsertedInDb(orderModel, sendToServer),
        )
        .onError(
      (error, stackTrace) {
        showToastMessage(error.toString());
      },
    );
  }

  Future<void> modifyOrderDetails(
      OrderEntityModel? orderModel, List<Product> orderProducts) async {
    List<OrderDetail> orderDetails = [];
    for (Product product in orderProducts) {
      OrderQuantity orderQuantity = OrderManager.getInstance()
          .calculateOrderQty(product.cartonQuantity ?? 0, product.qtyUnit ?? 0,
              product.qtyCarton ?? 0);
      OrderDetail orderDetail = OrderDetail(
          mLocalOrderId: orderModel?.order?.id,
          mProductId: product.id,
          mCartonQuantity: orderQuantity.cartons,
          mUnitQuantity: orderQuantity.units);
      orderDetail.setAvlQty(
          product.avlStockCarton ?? 0, product.avlStockUnit ?? 0);
      orderDetail.mCartonCode = product.cartonCode;
      orderDetail.mUnitCode = product.unitCode;
      orderDetail.mProductName = product.productName;
      orderDetail.actualCartonStock = product.actualCartonStock;
      orderDetail.actualUnitStock = product.actualUnitStock;
      orderDetail.unitDefinitionId = product.unitDefinitionId;
      orderDetail.cartonDefinitionId = product.cartonDefinitionId;
      orderDetail.mProductGroupId = product.groupId;
      orderDetail.type = ProductType.paid.name;
      orderDetail.cartonSize = product.cartonQuantity;
      orderDetail.packageId = product.packageId;
      orderDetails.add(orderDetail);
    }
    orderModel?.orderDetails = orderDetails;
    return await _repository.addOrderItems(orderDetails);
  }

  Future<void> onInsertedInDb(
      OrderEntityModel? orderModel, bool sendToServer) async {
    _repository.getOrderItems(orderModel?.order?.id).then(
      (orderDetails) async {
        if (orderDetails.isEmpty && sendToServer /*&& isNextClick*/) {
          Outlet outlet =
              await _statusRepository.findOutletById(_outletId ?? 0);
          outlet.avlStockDetail = _availableStockItems;
          updateOutlet(outlet);
          setNoOrder(true);
          return;
        } else {
          setNoOrder(false);
        }

        if (_order != null) {
          if (_order?.order != null) {
            if (_order?.order?.serverOrderId != null) {
              for (int i = 0; i < orderDetails.length; i++) {
                orderDetails[i].mOrderId = _order?.order?.serverOrderId;
              }
            }
          }
        }

        orderModel?.orderDetails = orderDetails;
        setOrder(orderModel);
        if (sendToServer) {
          composeOrderForServer();
        }
      },
    );
  }

  void composeOrderForServer() {
    if (_order != null) {
      setIsSaving(true);

      Order mOrder = Order(outletId: _order?.order?.outletId);
      mOrder.routeId = _order?.outlet?.routeId;
      mOrder.visitDayId = _order?.outlet?.visitDay;
      if (_order?.getOrder()?.orderStatus == null) {
        mOrder.orderStatus = 1; //2 created
      } else {
        mOrder.orderStatus =
            _order?.getOrder()?.orderStatus; // Server Side Status
      }
      mOrder.id = _order?.getOrder()?.id;

      if (_order?.getOrder() != null) {
        mOrder.serverOrderId = _order?.getOrder()?.id;
      }

      if (_order?.outlet?.visitTimeLat != null) {
        mOrder.latitude = (_order?.outlet
            ?.visitTimeLat); //             mOrder.setLatitude(order.getOutlet().getLatitude());
        mOrder.longitude = (_order?.outlet
            ?.visitTimeLng); // mOrder.setLongitude(order.getOutlet().getLongitude());
      }
//            mOrder = order.order;

      _order?.setOrder(mOrder);

      // Gson gson = new Gson();
      // String json = gson.toJson(mOrder);

      debugPrint("Order${jsonEncode(mOrder)}");

      OrderResponseModel responseModel =
          OrderResponseModel.fromJson(mOrder.toJson());
      responseModel.orderDetails = _order?.orderDetails
          ?.map(
            (e) => OrderDetailModel.fromJson(e.toJson()),
          )
          .toList();
//            responseModel.setAvailableStocks(order.getAvailableStockDetails());
      responseModel.distributionId = _distributionId;
      responseModel.organizationId = _order?.outlet?.organizationId;
      responseModel.channelId = _order?.outlet?.channelId;
      responseModel.outlet = _order!.outlet;

      calculateLocally(responseModel);
    }
  }

  Future<void> calculateLocally(OrderResponseModel responseModel) async {
    try {
      final pricingManager = PricingManager.getInstance();
      final syncDate = _repository.getWorkSyncData().syncDate;
      final formattedDate = Util.formatDate('yyyy-MM-dd', syncDate);

      final orderResponseModel = await pricingManager.calculatePriceBreakdown(
          responseModel, formattedDate);
      final orderTotalAmount = orderResponseModel.payable;
      final totalQty = getOrderTotalQty(orderResponseModel.orderDetails
          ?.map(
            (e) => OrderDetail.fromJson(e.toJson()),
          )
          .toList());

      final priceOutputDTO = await pricingManager.getOrderPrice(
        orderResponseModel,
        orderTotalAmount,
        totalQty,
        orderResponseModel.outletId,
        orderResponseModel.routeId,
        orderResponseModel.distributionId,
        formattedDate,
      );

      final priceBreakdownJson = jsonEncode(priceOutputDTO.priceBreakdown);
      final List<UnitPriceBreakDownModel> priceBreakDown =
          (jsonDecode(priceBreakdownJson) as List<dynamic>?)
                  ?.map((item) => UnitPriceBreakDownModel.fromJson(item))
                  .toList() ??
              [];

      orderResponseModel.priceBreakDown = priceBreakDown;
      orderResponseModel.payable = priceOutputDTO.totalPrice?.toDouble();

      if (orderResponseModel.orderDetails != null) {
        for (var orderDetail in orderResponseModel.orderDetails!) {
          if ((orderDetail.cartonFreeGoods != null &&
                  orderDetail.cartonFreeGoods!.isNotEmpty) ||
              (orderDetail.unitFreeGoods != null &&
                  orderDetail.unitFreeGoods!.isNotEmpty)) {
            orderDetail.cartonFreeGoods = [];
            orderDetail.unitFreeGoods = [];
          }
        }
      }

      final orderResponseModelCheck =
          await pricingManager.getFreeGoods(orderResponseModel, formattedDate);
      final orderModel = OrderEntityModel();
      // final orderString = jsonEncode(orderResponseModelCheck);
      final order = Order.fromJson(orderResponseModelCheck.toJson());

      orderModel.orderDetails = orderResponseModelCheck.orderDetails
          ?.map(
            (e) => OrderDetail.fromJson(e.toJson()),
          )
          .toList();
      orderModel.order = order;
      orderModel.outlet = _order?.outlet;
      orderModel.success =
          bool.parse(orderResponseModelCheck.success ?? "true");

      updateOrder(orderModel);
    } catch (e) {
      // onError(e);
      showToastMessage(e.toString());
    }
  }

  Future<void> updateOrder(OrderEntityModel? order) async {
    if (order != null &&
        order.order != null &&
        order.success! &&
        order.orderDetails != null) {
      if (order.order?.payable != null) {
        setOrder(order);

        if (order.order != null) {
          if (order.order?.serverOrderId != null) {
            if (order.orderDetails != null) {
              for (var orderDetail in order.orderDetails!) {
                orderDetail.mOrderId = order.order?.serverOrderId;
                if (orderDetail.cartonFreeGoods != null) {
                  if (orderDetail.cartonFreeGoods != null) {
                    for (var cartonFreeGood in orderDetail.cartonFreeGoods!) {
                      cartonFreeGood.mOrderId = order.order?.serverOrderId;
                    }
                  }
                }
              }
            }
          }
        }

        order.outlet?.avlStockDetail = _availableStockItems;

        _statusRepository.updateOutlet(order.outlet);
        final orderUpdateCompletable = _repository.updateOrder(order.order);
        final removeOrderItems =
            await _repository.deleteOrderItems(order.order?.id);
        final insertOrderItems =
            await _repository.addOrderItems(order.orderDetails);

        if (order.orderDetails != null) {
          for (var orderDetail in order.orderDetails!) {
            if (orderDetail.unitPriceBreakDown != null &&
                orderDetail.unitPriceBreakDown!.isNotEmpty) {
              _repository
                  .deleteOrderUnitPriceBreakdown(orderDetail.orderDetailId);
              _repository
                  .addOrderUnitPriceBreakDown(orderDetail.unitPriceBreakDown);
            }
            if (orderDetail.cartonPriceBreakDown != null &&
                orderDetail.cartonPriceBreakDown!.isNotEmpty) {
              _repository
                  .deleteOrderCartonPriceBreakdown(orderDetail.orderDetailId);
              _repository.addOrderCartonPriceBreakDown(
                  orderDetail.cartonPriceBreakDown);
            }
          }
        }

        orderUpdateCompletable
            .then(
              (value) => printInfo(info: "Update Order finished"),
            )
            .then((value) => removeOrderItems)
            .then(
              (value) => printInfo(info: "Remove Order Items finished"),
            )
            .then((value) => insertOrderItems)
            .then(
              (value) => printInfo(info: "Insert Order Items"),
            )
            .whenComplete(
          () {
            setOrderSaved(true);
            setIsSaving(false);
            // availableStockItems.clear();
            // msg.value = "Order Saved Successfully";
          },
        ).onError(
          (error, stackTrace) {
            debugPrint(e.toString());
            setOrderSaved(false);
            setIsSaving(false);
            setMessage(e.toString());
          },
        );
      }
    } else {
      setMessage(Constants.PRICING_ERROR);
      setIsSaving(false);
    }
  }

  Future<List<Product>> filterOrderProducts() async {
    List<Product> filteredProducts = [];

    //get all the products from database
    List<Product> allProducts = await getAllProducts();

    //filter products that have order or avl stock
    for (Product product in allProducts) {
      final orderQty = Util.convertToLongQuantity(
          orderQtyControllers[product.id ?? 0]?.text ?? "");
      if (orderQty != null &&
          orderQty.isNotEmpty &&
          (orderQty[0] > 0 || orderQty[1] > 0)) {
        product.setQty(orderQty[0], orderQty[1]);
        filteredProducts.add(product);
      }
    }

    return filteredProducts;
  }

  /*Future<List<Product>> filterOrderProducts() async {
    List<Product> filteredProducts = [];

    //get all the products from database
    List<Product> allProducts = await getAllProducts();

    //filter products that have order or avl stock
    for (Product product in allProducts) {
      final orderQty = Util.convertToLongQuantity(
          orderQtyControllers[product.id ?? 0]?.text ?? "");
      final avlStockQty = Util.convertToLongQuantity(
          avlStockControllers[product.id ?? 0]?.text ?? "");
      if ((orderQty != null && orderQty.isNotEmpty) ||
          (avlStockQty != null && avlStockQty.isNotEmpty)) {
        //add order quantity to product
        if (orderQty != null && orderQty.isNotEmpty) {
          product.setQty(orderQty[0], orderQty[1]);
        } else {
          product.setQty(0, 0);
        }

        //add available stock to product
        if (avlStockQty != null && avlStockQty.isNotEmpty) {
          product.setAvlStock(avlStockQty[0], avlStockQty[1]);
        }

        filteredProducts.add(product);
      }
    }

    return filteredProducts;
  }*/

  Future<List<AvailableStock>?> updateAvlStockItems(int? packageId) async {
    if (_availableStockItems != null && _availableStockItems!.isNotEmpty) {
      deleteAvlStockItemsByPackageID(packageId);
    }
    //get all the products from database
    List<Product> allProducts = await getAllProducts();

    for (Product product in allProducts) {
      AvailableStock availableStock = AvailableStock();

      final avlStockQty = Util.convertToLongQuantity(
          avlStockControllers[product.id ?? 0]?.text ?? "");

      if (avlStockQty != null && avlStockQty.isNotEmpty) {
        availableStock.packageId = product.packageId;
        availableStock.productId = product.id;
        availableStock.cartonQuantity = avlStockQty[0];
        availableStock.unitQuantity = avlStockQty[1];
        availableStock.unitProductDefinitionId = product.unitDefinitionId;
        availableStock.cartonProductDefinitionId = product.cartonDefinitionId;

        _availableStockItems?.add(availableStock);
      }
    }

    return _availableStockItems;
  }

  void deleteAvlStockItemsByPackageID(int? packageId) {
    if (packageId == null) return;

    List<AvailableStock> tempList = [];

    if (_availableStockItems != null && _availableStockItems!.isNotEmpty) {
      for (AvailableStock item in _availableStockItems!) {
        if (item.packageId == packageId) tempList.add(item);
      }

      _availableStockItems!.removeWhere(
        (element) => tempList.contains(element),
      );
    }
  }

  int getOrderTotalQty(List<OrderDetail>? orderDetails) {
    if (orderDetails != null || orderDetails!.isEmpty) return 0;

    int totalQuantity = 0;
    for (OrderDetail orderDetail in orderDetails) {
      int cartonQty = orderDetail.mCartonQuantity ?? 0;
      int unitQty = orderDetail.mUnitQuantity ?? 0;
      totalQuantity += (cartonQty + unitQty);
    }
    return totalQuantity;
  }

  Future<void> loadOutlet(int outletId) async {
    _outletId = outletId;

    outlet = await _repository.findOutletById(outletId);

    findOrder(outletId);

    //Add saved available stock item in List
    _availableStockItems?.clear();
    if(outlet?.avlStockDetail!=null) {
      _availableStockItems = outlet?.avlStockDetail;
    }else{
      _availableStockItems=[];
    }
    if (_availableStockItems != null) {
      // Log.d(TAG, availableStockItems.toString());
    }
  }

  RxList<Package> getAllPackages() => _packages;

  RxList<Product> getProductList() => _mutableProductList;

  RxList<ProductGroup> getAllProductGroups() => _productGroupList;

  RxBool getIsSaving() => _isSaving;

  RxBool noOrderTaken() => _noOrder;

  RxBool orderSaved() => _orderSaved;

  Rx<String> getMessage() => _msg;

  Future<List<Product>> getAllProducts() {
    return _repository.getAllProducts();
  }

  void setOrder(OrderEntityModel? order) {
    _order = order;
  }

  void updateFilteredProducts(List<Product> products) {
    filteredProducts(products);
    filteredProducts.refresh();
  }

  void setNoOrder(bool value) {
    _noOrder(value);
    _noOrder.refresh();
  }

  void setIsSaving(bool value) {
    _isSaving(value);
    _isSaving.refresh();
  }

  void setMessage(String msg) {
    _msg(msg);
    _msg.refresh();
  }

  void setOrderSaved(bool value) {
    _orderSaved(value);
    _orderSaved.refresh();
  }

  void updateOutlet(Outlet outlet) {
    _statusRepository.updateOutlet(outlet);
  }

  bool isShowMarketReturnButton() =>
      /*_repository.isShowMarketReturnButton()*/ true;

  Future<void> saveOrderAndAvailableStockData() async {
    //delete already saved data
    _repository.deleteOrderAndAvailableStockByOutlet(_outletId);

    List<OrderAndAvailableQuantity> orderQuantityList = [];
    //get all the products from database
    List<Product> allProducts = await getAllProducts();

    for (Product product in allProducts) {
      OrderAndAvailableQuantity orderQuantity = OrderAndAvailableQuantity();
      orderQuantity.productId = product.id;
      orderQuantity.outletId = _outletId;

      final avlStockQty = Util.convertToLongQuantity(
          avlStockControllers[product.id ?? 0]?.text ?? "");
      final orderQty = Util.convertToLongQuantity(
          orderQtyControllers[product.id ?? 0]?.text ?? "");

      if (avlStockQty != null || orderQty != null) {
        if (avlStockQty != null && avlStockQty.isNotEmpty) {
          orderQuantity.setAvlQuantity(avlStockQty[0], avlStockQty[1]);
        }

        if (orderQty != null && orderQty.isNotEmpty) {
          orderQuantity.setOrderQuantity(orderQty[0], orderQty[1]);
        }

        orderQuantityList.add(orderQuantity);
      }
    }

    _repository.saveOrderAndAvailableStockData(orderQuantityList);
  }

  Future<List<OrderAndAvailableQuantity>>
      getOrderAndAvailableQuantityDataByOutlet(int? outletId) {
    return _repository.getOrderAndAvailableQuantityDataByOutlet(outletId);
  }

  OrderAndAvailableQuantity? getOrderQuantityByProduct(
      List<OrderAndAvailableQuantity> orderQuantityList, int? productId) {
    List<OrderAndAvailableQuantity> list = orderQuantityList
        .where(
          (element) => element.productId == productId,
        )
        .toList();

    if (list.isNotEmpty) {
      return list.first;
    }
    return null;
  }
}
