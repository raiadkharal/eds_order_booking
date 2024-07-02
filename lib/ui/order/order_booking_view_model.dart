import 'package:get/get.dart';
import 'package:order_booking/db/entities/order/order.dart';
import 'package:order_booking/db/entities/order_detail/order_detail.dart';
import 'package:order_booking/db/entities/packages/package.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/db/entities/product_group/product_group.dart';
import 'package:order_booking/model/order_detail_model/order_detail_model.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';
import 'package:order_booking/ui/order/order_booking_repository.dart';
import 'package:order_booking/utils/Constants.dart';
import 'package:order_booking/utils/utils.dart';

import '../../db/entities/available_stock/available_stock.dart';
import '../../model/order_model/order_model.dart';
import '../../model/packageModel/package_model.dart';
import '../../utils/enums.dart';
import 'order_manager.dart';

class OrderBookingViewModel extends GetxController {
  final OrderBookingRepository _repository;

  final RxList<Package> _packages = RxList<Package>();
  final RxList<Product> filteredProducts = RxList<Product>();
  final RxList<ProductGroup> _productGroupList = RxList<ProductGroup>();
  final RxList<PackageModel> _mutablePkgList = RxList<PackageModel>();
  final RxBool isSaving = false.obs;

  OrderEntityModel? order;
  List<AvailableStock>? availableStockItems;
  int? outletId;

  OrderBookingViewModel(this._repository);

  @override
  void onReady() async {
    _packages(await _repository.findAllPackages());
    _productGroupList(await _repository.findAllGroups());
    filterProductsByPackage(_packages.first.packageId);
    super.onReady();
  }

  RxList<Package> getAllPackages() => _packages;

  RxList<PackageModel> getProductList() => _mutablePkgList;

  void updateFilteredProducts(List<Product> products) {
    filteredProducts(products);
    filteredProducts.refresh();
  }

  RxList<ProductGroup> getAllProductGroups() => _productGroupList;

  Future<void> filterProductsByPackage(int? packageId) async {

    if(packageId==null){
      return;
    }

    final allProductsByPackage =
        _repository.findAllProductsByPackage(packageId);

    if (order == null) {
      allProductsByPackage.then(
        (products) {
          onProductsLoaded(products, packageId);
          updateFilteredProducts(products);
        },
      ).onError(
        (error, stackTrace) {
          showToastMessage(error.toString());
        },
      );
      return;
    }

    final List<OrderDetail> allAddedProducts =
        await _repository.getOrderItems(order?.order?.id);

    Future<List<Product>> zippedSingleSource;

    if (availableStockItems != null && availableStockItems!.isNotEmpty) {
      zippedSingleSource = updateProducts(
          availableStockItems, await allProductsByPackage, allAddedProducts);
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
              orderDetail.mCartonQuantity ?? 0, orderDetail.mUnitQuantity ?? 0);
          product.setAvlStock(orderDetail.avlCartonQuantity ?? 0,
              orderDetail.avlUnitQuantity ?? 0);
        }
      }

      if (availableStockItems != null) {
        for (AvailableStock availableStock in availableStockItems) {
          if (product.id == availableStock.productId) {
            product.setAvlStock(
                availableStock.cartonQuantity??0, availableStock.unitQuantity??0);
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
              orderDetail.mCartonQuantity ?? 0, orderDetail.mUnitQuantity ?? 0);
          product.setAvlStock(orderDetail.avlCartonQuantity ?? 0,
              orderDetail.avlUnitQuantity ?? 0);
        }
      }
    }

    return filteredProducts;
  }

  void onProductsLoaded(List<Product> products, int? packageId) async {
    if (products.isNotEmpty) {
      products = await _repository.findAllProductsByPackage(packageId);
    }

    // Log.d("PackageId", products.size() + "After Size");

    _mutablePkgList(_repository.packageModel(_packages, products));
    isSaving(false);
  }

  Future<void> addOrder(
      List<Product> orderItems, int? packageId, bool sendToServer) async {
    if (order == null) {
      OrderModel order = OrderModel(outletId: outletId);
      _repository
          .createOrder(order)
          .whenComplete(() => addOrderItems(orderItems, sendToServer));
    } else {
//                repository.deleteOrderItemsByGroup(order.getOrder().getLocalOrderId(),groupId);
      _repository
          .deleteOrderItemsByPackage(order?.order?.id, packageId)
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
        .findOrder(outletId)
        .then(
          (orderModel) => modifyOrderDetails(orderModel, orderItems),
        )
        .then(
          (value) => _repository.findOrder(outletId),
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
          mOrderId: orderModel?.order?.id,
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
      OrderEntityModel? orderModel, bool sendToServer) async {}
}
