import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:order_booking/db/dao/pricing_dao.dart';
import 'package:order_booking/db/dao/product_dao.dart';
import 'package:order_booking/db/entities/pricing/price_condition_entities/price_condition_entities.dart';
import 'package:order_booking/ui/order/pricing/price_condition_details_with_scale/price_condition_details_with_scale.dart';
import 'package:order_booking/ui/order/pricing/price_condtition_with_access_sequence/price_condtition_with_access_sequence.dart';
import 'package:order_booking/ui/order/pricing/price_output_dto/price_output_dto.dart';
import 'package:order_booking/ui/order/pricing/promo_limit_dto/promo_limit_dto.dart';

import '../../../db/dao/price_condition_detail_dao.dart';
import '../../../db/entities/available_stock/available_stock.dart';
import '../../../db/entities/carton_price_breakdown/carton_price_breakdown.dart';
import '../../../db/entities/order_detail/order_detail.dart';
import '../../../db/entities/outlet_availed_promotion/outlet_availed_promotion.dart';
import '../../../db/entities/pricing/free_good_groups/free_good_groups.dart';
import '../../../db/entities/pricing/free_goods_detail/free_goods_detail.dart';
import '../../../db/entities/pricing/price_access_sequence/price_access_sequence.dart';
import '../../../db/entities/pricing/price_condition_class/price_condition_class.dart';
import '../../../db/entities/pricing/price_condition_detail/price_condition_detail.dart';
import '../../../db/entities/pricing/price_condition_scale/price_condition_scale.dart';
import '../../../db/entities/pricing/price_condition_type/price_condition_type.dart';
import '../../../db/entities/pricing/pricing_area/pricing_area.dart';
import '../../../db/entities/product/product.dart';
import '../../../db/entities/product_quantity/product_quantity.dart';
import '../../../db/entities/unit_price_breakdown/unit_price_breakdown.dart';
import '../../../model/order_detail_model/order_detail_model.dart';
import '../../../model/order_response_model/order_response_model.dart';
import '../../../utils/enums.dart';
import 'combined_max_limit_holder_dto/combined_max_limit_holder_dto.dart';
import 'free_good_output_dto/free_good_output_dto.dart';
import 'item_amount_dto/item_amount_dto.dart';
import 'message/message.dart';

class PricingManager {
  final PricingDao pricingDao;
  final ProductDao productDao;
  final PriceConditionDetailDao conditionDetailDao;

  static PricingManager? ourInstance;

  static PricingManager getInstance() {
    ourInstance ??= PricingManager(Get.find(), Get.find(), Get.find());
    return ourInstance!;
  }

  PricingManager(this.pricingDao, this.productDao, this.conditionDetailDao);

  PriceOutputDTO objPriceOutputDTO = PriceOutputDTO(priceBreakdown: [],messages: []);
  double totalPrice = 0.0; //input price for every condition class
  double subTotal = 0.0; //input price for every condition class

  bool isPriceFound = false;

  Future<int> priceConditionClassValidation() async =>
      pricingDao.priceConditionClassValidation();

  Future<int> priceConditionValidation() =>
      pricingDao.priceConditionValidation();

  Future<int> priceConditionTypeValidation() =>
      pricingDao.priceConditionTypeValidation();

  Future<PriceOutputDTO> getOrderPrice(
      OrderResponseModel orderResponseModel,
      double? orderTotalAmount,
      int? quantity,
      int? outletId,
      int? routeId,
      int? distributionId,
      String date) async {

    totalPrice = orderTotalAmount??0.0; //input price for every condition class
    isPriceFound = false;

    // Fetch pricing areas and condition classes asynchronously
    final pricingAreas = await pricingDao.findPricingArea();
    final conditionClasses = await pricingDao.findPriceConditionClasses(2);

    for (final conditionClass in conditionClasses) {
      isPriceFound = false;
      final conditionTypes = await pricingDao
          .findPriceConditionTypes(conditionClass.priceConditionClassId);

      for (final conditionType in conditionTypes) {
        List<PriceConditionWithAccessSequence> priceConditions =
            await pricingDao.getPriceConditionAndAccessSequenceByTypeId(
                conditionType.priceConditionTypeId,
                orderResponseModel.outlet?.vpoClassificationId,
                orderResponseModel.outlet?.pricingGroupId ?? 0,
                orderResponseModel.channelId,
                orderResponseModel.organizationId,
                orderResponseModel.outlet?.promoTypeId,
                orderResponseModel.outlet?.customerRegistrationTypeId,
                date,
                distributionId ?? 0,
                outletId ?? 0);

        // Sort price conditions based on the order
        priceConditions.sort((o1, o2) => o1.order!.compareTo(o2.order!));

        for (final priceCondition in priceConditions) {
          PromoLimitDTO? limit = await getPriceAgainstPriceConditionForInvoice(
              priceCondition.priceConditionId,
              priceCondition.sequenceCode,
              outletId,
              quantity,
              totalPrice,
              conditionType.priceScaleBasisId,
              routeId,
              distributionId,
              orderResponseModel.outlet?.channelId);

          if (limit != null && limit.unitPrice! > -1.0) {
            isPriceFound = true;

            final objSingleBlock = UnitPriceBreakDown();
            if (limit.limitBy != null) {
              objSingleBlock.maximumLimit = limit.maximumLimit?.toDouble();
              objSingleBlock.limitBy = limit.limitBy;

              // Additional checks for combined limits
              if (objSingleBlock.limitBy == LimitBy.amount.index + 1 &&
                  priceCondition.combinedMaxValueLimit != null) {
                objSingleBlock.maximumLimit =
                    priceCondition.combinedMaxValueLimit;
              } else if (objSingleBlock.limitBy == LimitBy.quantity.index + 1 &&
                  priceCondition.combinedMaxCaseLimit != null) {
                objSingleBlock.maximumLimit =
                    priceCondition.combinedMaxCaseLimit;
              }
            }

            // Calculate block price
            ItemAmountDTO blockPrice = calculateBlockPrice(
                totalPrice,
                limit.unitPrice?.toDouble(),
                quantity,
                conditionType.priceScaleBasisId,
                conditionType.operationType,
                conditionType.calculationType,
                conditionType.roundingRule,
                objSingleBlock.limitBy,
                objSingleBlock.maximumLimit,
                objSingleBlock.alreadyAvailed ?? 0,
                totalPrice);

            totalPrice = blockPrice.totalPrice!;
            objSingleBlock.priceConditionType = conditionType.name;
            objSingleBlock.priceConditionClass = conditionClass.name;
            objSingleBlock.priceCondition = priceCondition.name;
            objSingleBlock.accessSequence = priceCondition.sequenceName;
            objSingleBlock.calculationType = conditionType.calculationType;
            objSingleBlock.unitPrice = limit.unitPrice?.toDouble();
            objSingleBlock.blockPrice = blockPrice.blockPrice;
            objSingleBlock.priceConditionDetailId =
                limit.priceConditionDetailId;
            objSingleBlock.priceConditionId = priceCondition.priceConditionId;
            objSingleBlock.priceConditionClassId =
                conditionClass.priceConditionClassId;
            objSingleBlock.totalPrice = totalPrice;

            objPriceOutputDTO.priceBreakdown?.add(objSingleBlock);

            if (blockPrice.isMaxLimitReached ?? false) {
              final message = Message();
              message.MessageSeverityLevel = conditionClass.severityLevel;
              message.MessageText =
                  'Max limit crossed for ${objSingleBlock.priceCondition}';

              objPriceOutputDTO.messages?.add(message);
            }
            break;
          }
        }
      }

      if (!isPriceFound &&
          (conditionClass.severityLevelMessage != null &&
              conditionClass.severityLevelMessage!.isNotEmpty) &&
          conditionClass.severityLevel !=
              MessageSeverityLevel.MESSAGE.index + 1) {
        final message = Message();
        message.MessageSeverityLevel = conditionClass.severityLevel;
        message.MessageText = conditionClass.severityLevelMessage;

        objPriceOutputDTO.messages?.add(message);
      }
    }

    objPriceOutputDTO.totalPrice = totalPrice.roundToDouble();
    return objPriceOutputDTO;
  }

  Future<PromoLimitDTO?> getPriceAgainstPriceConditionForInvoice(
      int? priceConditionId,
      String? accessSequence,
      int? outletId,
      int? quantity,
      double? totalPrice,
      int? scaleBasisId,
      int? routeId,
      int? distributionId,
      int? channelId) async {
    PromoLimitDTO promoLimitDTO;

    switch (accessSequence?.toUpperCase()) {
      case 'OUTLET':
        promoLimitDTO = await getPriceAgainstOutlet(
            priceConditionId, outletId, quantity, totalPrice, scaleBasisId);
        break;
      case 'ROUTE':
        promoLimitDTO = await getPriceAgainstRoute(
            priceConditionId, routeId, quantity, totalPrice, scaleBasisId);
        break;
      case 'DISTRIBUTION':
        promoLimitDTO = await getPriceAgainstDistribution(priceConditionId,
            distributionId, quantity, totalPrice, scaleBasisId);
        break;
      default:
        promoLimitDTO =
            PromoLimitDTO(); // Default to an empty DTO or handle as required
    }

    return promoLimitDTO;
  }

  Future<PromoLimitDTO> getPriceAgainstOutlet(
      int? priceConditionId,
      int? outletId,
      int? quantity,
      double? totalPrice,
      int? scaleBasisId) async {
    PriceConditionDetailsWithScale? priceConditionDetail =
        await conditionDetailDao.findPriceConditionDetails(
            priceConditionId, outletId);

    if (priceConditionDetail == null) {
      return PromoLimitDTO(); // Handle null case
    }

    PriceConditionDetail? detail = priceConditionDetail.priceConditionDetail;
    PromoLimitDTO maxLimitDTO = PromoLimitDTO()
      ..priceConditionDetailId = detail?.priceConditionDetailId
      ..limitBy = detail?.limitBy
      ..maximumLimit = detail?.maximumLimit ?? 0.0;

    final scales = priceConditionDetail.priceConditionScaleList;

    double? unitPrice = getScaledAmount(scales, detail?.priceConditionDetailId,
        scaleBasisId, quantity, totalPrice, false);
    maxLimitDTO.unitPrice = (scales == null || scales.isEmpty)
        ? (detail?.amount ?? -1)
        : unitPrice ?? -1.0;

    return maxLimitDTO;
  }

  Future<PromoLimitDTO> getPriceAgainstRoute(
      int? priceConditionId,
      int? routeId,
      int? quantity,
      double? totalPrice,
      int? scaleBasisId) async {
    PromoLimitDTO maxLimitDTO = PromoLimitDTO();

    PriceConditionDetailsWithScale? priceConditionDetail =
        await conditionDetailDao.findPriceConditionDetailsRoute(
            priceConditionId, routeId);

    if (priceConditionDetail != null) {
      PriceConditionDetail? detail = priceConditionDetail.priceConditionDetail;
      maxLimitDTO.priceConditionDetailId = detail?.priceConditionDetailId;
      maxLimitDTO.limitBy = detail?.limitBy;
      maxLimitDTO.maximumLimit = detail?.maximumLimit ?? -1.0;
      if (priceConditionDetail.priceConditionScaleList?.isEmpty ?? true) {
        maxLimitDTO.unitPrice = detail?.amount ?? -1.0;
      } else {
        double? unitPrice = getScaledAmount(
            priceConditionDetail.priceConditionScaleList,
            detail?.priceConditionDetailId,
            scaleBasisId,
            quantity,
            totalPrice,
            false);
        maxLimitDTO.unitPrice = unitPrice ?? 0.0;
      }
    }

    return maxLimitDTO;
  }

  Future<PromoLimitDTO> getPriceAgainstDistribution(
      int? priceConditionId,
      int? distributionId,
      int? quantity,
      double? totalPrice,
      int? scaleBasisId) async {
    PromoLimitDTO maxLimitDTO = PromoLimitDTO();

    PriceConditionDetailsWithScale? priceConditionDetail =
        await conditionDetailDao.findPriceConditionDetailsDistribution(
            priceConditionId, distributionId);

    if (priceConditionDetail != null) {
      PriceConditionDetail? detail = priceConditionDetail.priceConditionDetail;
      maxLimitDTO.priceConditionDetailId = detail?.priceConditionDetailId;
      maxLimitDTO.limitBy = detail?.limitBy;
      maxLimitDTO.maximumLimit = detail?.maximumLimit?.toDouble() ?? -1.0;
      if (priceConditionDetail.priceConditionScaleList?.isEmpty ?? true) {
        maxLimitDTO.unitPrice = detail?.amount?.toDouble() ?? -1.0;
      } else {
        double? unitPrice = getScaledAmount(
            priceConditionDetail.priceConditionScaleList,
            detail?.priceConditionDetailId,
            scaleBasisId,
            quantity,
            totalPrice,
            false);
        maxLimitDTO.unitPrice = unitPrice ?? 0;
      }
    }

    return maxLimitDTO;
  }

  double? getScaledAmount(
      List<PriceConditionScale?>? scaleList,
      int? priceConditionDetailId,
      int? scaleBasisId,
      int? quantity,
      double? totalPrice,
      bool? useCartonAmount) {
    double? returnAmount = 0.0;

    if (scaleList != null &&
        (scaleBasisId == ScaleBasis.Quantity.index + 1 ||
            scaleBasisId == ScaleBasis.Total_Quantity.index + 1)) {
      scaleList.sort((a, b) => b!.from!.compareTo(a?.from ?? 0));
      for (var conditionScale in scaleList) {
        if (conditionScale?.priceConditionDetailId == priceConditionDetailId &&
            conditionScale!.from! <= quantity!) {
          if (useCartonAmount ?? false) {
            if (conditionScale.cartonAmount != null) {
              returnAmount = conditionScale.cartonAmount;
            }
          } else {
            returnAmount = conditionScale.amount;
          }
          break;
        }
      }
    } else if (scaleList != null &&
        (scaleBasisId == ScaleBasis.Value.index + 1)) {
      scaleList.sort((a, b) => b!.amount!.compareTo(a?.amount ?? 0));
      for (var conditionScale in scaleList) {
        if (conditionScale?.priceConditionDetailId == priceConditionDetailId &&
            conditionScale!.from! <= totalPrice!.toDouble()) {
          if (useCartonAmount ?? false) {
            if (conditionScale.cartonAmount != null) {
              returnAmount = conditionScale.cartonAmount;
            }
          } else {
            returnAmount = conditionScale.amount;
          }
          break;
        }
      }
    }

    return returnAmount;
  }

  ItemAmountDTO calculateBlockPrice(
      double? inputAmount,
      double? amount,
      int? quantity,
      int? scaleBasisId,
      int? operationType,
      int? calculationType,
      int? roundingRule,
      int? limitBy,
      double? maxLimit,
      double? alreadyAvailed,
      double? totalPrice) {
    ItemAmountDTO objReturnPrice = ItemAmountDTO();
    double blockPrice = 0;
    int? actualQuantity = quantity;
    limitBy ??= 0;

    if (limitBy == LimitBy.quantity.index + 1) {
      alreadyAvailed ??= 0.0;
      int remainingQuantity = maxLimit?.toInt() ?? 0 - alreadyAvailed.toInt();
      remainingQuantity = remainingQuantity < 0 ? 0 : remainingQuantity;

      if (remainingQuantity < (actualQuantity ?? 0)) {
        actualQuantity = remainingQuantity;
        objReturnPrice.isMaxLimitReached = true;
      }
      objReturnPrice.actualQuantity = actualQuantity;
    }

    if (scaleBasisId == ScaleBasis.Quantity.index + 1) {
      objReturnPrice.totalPrice = 0;
      objReturnPrice.blockPrice = (amount ?? 0) * (actualQuantity ?? 0);
      blockPrice = (amount ?? 0) * (actualQuantity ?? 0);
    } else if (scaleBasisId == ScaleBasis.Value.index + 1 ||
        scaleBasisId == ScaleBasis.Total_Quantity.index + 1) {
      objReturnPrice.totalPrice = 0;
      objReturnPrice.blockPrice = amount;
      blockPrice = amount ?? 0;
    }

    if (calculationType == CalculationType.Fix.index + 1) {
      if (limitBy == LimitBy.amount.index + 1) {
        blockPrice =
            getRemainingBlockPrice(blockPrice, maxLimit, alreadyAvailed) ?? 0;
        if (blockPrice < (objReturnPrice.blockPrice ?? 0)) {
          objReturnPrice.isMaxLimitReached = true;
          objReturnPrice.blockPrice = blockPrice;
        }
      }
      if (operationType == OperationType.Plus.index + 1) {
        objReturnPrice.totalPrice = (totalPrice ?? 0) + blockPrice;
      } else if (operationType == OperationType.Minus.index + 1) {
        objReturnPrice.totalPrice = ((totalPrice ?? 0) - blockPrice) < 0
            ? 0
            : (totalPrice ?? 0) - blockPrice;
      }
    } else if (calculationType == CalculationType.Percentage.index + 1) {
      double value = ((inputAmount ?? 0) * (amount ?? 0)) / 100;
      double actualValue = value;
      if (limitBy == LimitBy.amount.index + 1) {
        actualValue =
            getRemainingBlockPrice(value, maxLimit, alreadyAvailed) ?? 0;
        if (actualValue < value) {
          objReturnPrice.isMaxLimitReached = true;
        }
      }
      objReturnPrice.blockPrice = actualValue;
      if (operationType == OperationType.Plus.index + 1) {
        objReturnPrice.totalPrice = (totalPrice ?? 0) + actualValue;
      } else if (operationType == OperationType.Minus.index + 1) {
        objReturnPrice.totalPrice = ((totalPrice ?? 0) - actualValue) < 0
            ? 0
            : (totalPrice ?? 0) - actualValue;
      }
    }

    if (roundingRule == (RoundingRule.Zero_Decimal_Precision.index + 1)) {
      objReturnPrice.totalPrice =
          roundToPrecision(objReturnPrice.totalPrice ?? 0, 0);
    } else if (roundingRule == RoundingRule.Two_Decimal_Precision.index + 1) {
      objReturnPrice.totalPrice =
          roundToPrecision(objReturnPrice.totalPrice ?? 0, 2);
    } else if (roundingRule == RoundingRule.Ceiling.index + 1) {
      objReturnPrice.totalPrice = objReturnPrice.totalPrice?.ceilToDouble();
    } else if (roundingRule == RoundingRule.Floor.index + 1) {
      objReturnPrice.totalPrice = objReturnPrice.totalPrice?.floorToDouble();
    }

    return objReturnPrice;
  }

  double roundToPrecision(double value, int precision) {
    num mod = pow(10.0, precision);
    return (value * mod).round().toDouble() / mod;
  }

  double? getRemainingBlockPrice(
      double? amount, double? maxLimit, double? alreadyAvailed) {
    alreadyAvailed ??= 0.0;
    maxLimit ??= 0.0;
    double remainingAmount = maxLimit - alreadyAvailed;
    if (remainingAmount < (amount ?? 0)) {
      amount = remainingAmount;
    }
    return amount;
  }

  Future<OrderResponseModel> calculatePriceBreakdown(
      OrderResponseModel orderModel, String date) async {
    Map<OrderDetail, List<OrderDetail>> orderItems =
        composeNewOrderItemsListForCalc(orderModel.orderDetails?.map(
              (e) => OrderDetail.fromJson(e.toJson()),
        )
            .toList()) ?? {};

    final finalOrderDetailList = <OrderDetail>[];
    final finalAvlStockDetailList = <AvailableStock>[];
    double payable = 0.0;
    double totalQuantity = 0.0;
    PriceOutputDTO? priceOutputDTO;
    List<ProductQuantity> productQuantityDTOList = <ProductQuantity>[];

    for (var entry in orderItems.entries) {
      for (var orderDetail in entry.value) {
        if (orderDetail.type != 'freegood') {
          productQuantityDTOList.add(ProductQuantity(
            productDefinitionId: orderDetail.productTempDefinitionId,
            quantity: orderDetail.productTempQuantity,
            packageId: orderDetail.packageId,
          ));
          totalQuantity += orderDetail.productTempQuantity?.toInt() ?? 0;
        }
      }
    }

    await pricingDao.deleteAllTempQty();
    await addProductQty(productQuantityDTOList);

    List<CombinedMaxLimitHolderDTO> combinedMaxLimitHolderDTOList =
        <CombinedMaxLimitHolderDTO>[];
    for (var entry in orderItems.entries) {
      final orderDetailKey = entry.key;
      for (var orderDetail in entry.value) {
        if (orderDetail.type != 'freegood') {
          priceOutputDTO = await getOrderItemPrice(
            productQuantityDTOList,
            orderDetail.orderDetailId,
            orderModel.outletId,
            orderDetail.productTempDefinitionId,
            orderDetail.productTempQuantity,
            orderModel.routeId,
            orderModel.distributionId,
            combinedMaxLimitHolderDTOList,
            orderModel,
            date,
            orderDetail.mProductId,
          );

          final priceBreakdownJson = jsonEncode(priceOutputDTO.priceBreakdown);
          if (orderDetail.productTempDefinitionId ==
              orderDetail.cartonDefinitionId) {
            List<CartonPriceBreakDown> priceBreakDown =
                (jsonDecode(priceBreakdownJson) as List<dynamic>?)
                        ?.map((e) => CartonPriceBreakDown.fromJson(e))
                        .toList() ??
                    [];
            orderDetailKey.cartonPriceBreakDown = priceBreakDown;
            orderDetailKey.mCartonQuantity =
                orderDetail.productTempQuantity?.toInt();
            orderDetailKey.cartonTotalPrice =
                priceOutputDTO.totalPrice?.toDouble();
          } else {
            orderDetailKey.unitPriceBreakDown = priceOutputDTO.priceBreakdown;
            orderDetailKey.mUnitQuantity =
                orderDetail.productTempQuantity?.toInt();
            orderDetailKey.unitTotalPrice =
                priceOutputDTO.totalPrice?.toDouble();
          }
          orderDetailKey.mCartonOrderDetailId =
              orderDetail.mCartonOrderDetailId;
          orderDetailKey.mUnitOrderDetailId = orderDetail.mUnitOrderDetailId;
          orderDetailKey.productTempDefinitionId =
              orderDetail.productTempDefinitionId;
          orderDetailKey.productTempQuantity = orderDetail.productTempQuantity;
          orderDetailKey.mLocalOrderId = orderDetail.mLocalOrderId;

          payable += priceOutputDTO.totalPrice?.toDouble() ?? 0.0;
        }
      }
      finalOrderDetailList.add(orderDetailKey);
    }

    orderModel.payable = (payable);
    orderModel.subtotal = (payable);
    orderModel.orderDetails = (finalOrderDetailList.map(
          (e) => OrderDetailModel.fromJson(e.toJson()),
    )
        .toList());
    orderModel.success = "true";

    return orderModel;
  }

  Map<OrderDetail, List<OrderDetail>>? composeNewOrderItemsListForCalc(
      List<OrderDetail>? originalDetailsList) {
    final orderDetailListMap = HashMap<OrderDetail, List<OrderDetail>>();

    if (originalDetailsList == null || originalDetailsList.isEmpty) return null;

    for (var orderDetail in originalDetailsList) {
      final newOrderLineItems = <OrderDetail>[];

      if (orderDetail.mUnitQuantity != null && orderDetail.mUnitQuantity! > 0) {
        final json = jsonEncode(orderDetail.toJson());
        final newUnitProd = OrderDetail.fromJson(jsonDecode(json));
        newUnitProd.productTempDefinitionId = orderDetail.unitDefinitionId;
        newUnitProd.productTempQuantity = orderDetail.mUnitQuantity;
        newOrderLineItems.add(newUnitProd);
      }

      if (orderDetail.mCartonQuantity != null &&
          orderDetail.mCartonQuantity! > 0) {
        final json = jsonEncode(orderDetail.toJson());
        final newCartonProd = OrderDetail.fromJson(jsonDecode(json));
        newCartonProd.productTempDefinitionId = orderDetail.cartonDefinitionId;
        newCartonProd.productTempQuantity = orderDetail.mCartonQuantity;
        newOrderLineItems.add(newCartonProd);
      }

      orderDetailListMap[orderDetail] = newOrderLineItems;
    }

    return orderDetailListMap;
  }

  Future<PriceOutputDTO> getOrderItemPrice(
      List<ProductQuantity>? productQuantityDTOList,
      int? mobileOrderDetailId,
      int? outletId,
      int? productDefinitionId,
      int? quantity,
      int? routeId,
      int? distributionId,
      List<CombinedMaxLimitHolderDTO> combinedMaxLimitHolderDTOList,
      OrderResponseModel orderResponseModel,
      String date,
      int? productId) async {
    PriceOutputDTO objPriceOutputDTO = PriceOutputDTO(priceBreakdown: [],messages: []);
    double totalPrice = 0.0;
    double subTotal = 0.0;
    bool isPriceFound = false;

    List<PriceConditionClass> conditionClasses =
        await pricingDao.findPriceConditionClasses(1);

    for (var conditionClass in conditionClasses) {
      List<PriceConditionType> conditionTypes = await pricingDao
          .findPriceConditionTypes(conditionClass.priceConditionClassId);
      isPriceFound = false;

      for (var conditionType in conditionTypes) {
        List<PriceConditionWithAccessSequence> priceConditions;
        List<int> bundleIds = await getBundlesList(
            productDefinitionId, conditionType.priceConditionTypeId);
        List<int> bundlesToApply = await getBundlesToApply(bundleIds);
        List<PriceConditionWithAccessSequence> filterPriceConditions = [];

        if (bundlesToApply.isEmpty) {
          priceConditions =
              await pricingDao.getPriceConditionAndAccessSequenceByTypeId(
            conditionType.priceConditionTypeId,
            orderResponseModel.outlet?.vpoClassificationId ?? 0,
            orderResponseModel.outlet?.pricingGroupId ?? 0,
            orderResponseModel.channelId,
            orderResponseModel.organizationId ?? 0,
            orderResponseModel.outlet?.outletPromoConfigId,
            orderResponseModel.outlet?.customerRegistrationTypeId,
            date,
            distributionId ?? 0,
            outletId ?? 0,
          );

          // filterPriceConditions = priceConditions
          //     .where((pcas) =>
          //         (pcas.channelAttributeCount == 0 ||
          //             pcas.outletChannelAttribute! > 0) &&
          //         (pcas.groupAttributeCount == 0 ||
          //             pcas.outletGroupAttribute! > 0) &&
          //         (pcas.vpoClassificationAttributeCount == 0 ||
          //             pcas.outletVPOClassificationAttributeCount! > 0))
          //     .toList();

          for (PriceConditionWithAccessSequence priceConditionWithAccessSequence
              in priceConditions) {
            if ((priceConditionWithAccessSequence.ChannelAttributeCount == 0 ||
                    (priceConditionWithAccessSequence.OutletChannelAttribute ??
                            0) >
                        0) &&
                (priceConditionWithAccessSequence.GroupAttributeCount == 0 ||
                    (priceConditionWithAccessSequence.OutletGroupAttribute ??
                            0) >
                        0) &&
                (priceConditionWithAccessSequence
                            .VPOClassificationAttributeCount ==
                        0 ||
                    (priceConditionWithAccessSequence
                                .OutletVPOClassificationAttributeCount ??
                            0) >
                        0)) {
              filterPriceConditions.add(priceConditionWithAccessSequence);
            }
          }
        } else {
          priceConditions = await pricingDao
              .getPriceConditionAndAccessSequenceByTypeIdWithBundle(
                  conditionType.priceConditionTypeId, bundlesToApply);
        }

        filterPriceConditions.sort((o1, o2) => o1.order!.compareTo(o2.order!));
        for (var prAccSeqDetail in filterPriceConditions) {
          int? packageId;
          if (productQuantityDTOList != null &&
              productQuantityDTOList.isNotEmpty) {
            for (var productQuantity in productQuantityDTOList) {
              if (productDefinitionId == productQuantity.productDefinitionId) {
                packageId = productQuantity.packageId;
              }
            }
          }

          int pcDefinitionLevelId =
              (EnumPCDefinitionLevel.ProductLevel.index + 1);
          if (conditionType.pcDefinitionLevelId != null) {
            pcDefinitionLevelId = conditionType.pcDefinitionLevelId!;
          }

          PromoLimitDTO? limitDTO = await getPriceAgainstPriceCondition(
            prAccSeqDetail.priceConditionId,
            prAccSeqDetail.sequenceCode,
            outletId,
            productDefinitionId,
            quantity,
            totalPrice,
            conditionType.priceScaleBasisId,
            routeId,
            distributionId,
            prAccSeqDetail.bundleId,
            orderResponseModel.channelId,
            packageId,
            pcDefinitionLevelId,
          );

          if (limitDTO != null && limitDTO.unitPrice!.toDouble() > -1) {
            isPriceFound = true;
            UnitPriceBreakDown objSingleBlock = UnitPriceBreakDown();

            objSingleBlock.priceConditionDetailId =
                limitDTO.priceConditionDetailId;
            objSingleBlock.orderDetailId = mobileOrderDetailId;

            CombinedMaxLimitHolderDTO? existingCombinedLimit;
            if (pcDefinitionLevelId ==
                    (EnumPCDefinitionLevel.PackageLevel.index + 1) ||
                (conditionType.isLRB ?? true)) {
              if (prAccSeqDetail.combinedLimitBy != null) {
                existingCombinedLimit =
                    combinedMaxLimitHolderDTOList.firstWhere(
                        (combinedMaxLimitHolderDTO) =>
                            combinedMaxLimitHolderDTO.priceConditionId ==
                            prAccSeqDetail.priceConditionId,
                        orElse: () => CombinedMaxLimitHolderDTO());
              } else {
                existingCombinedLimit =
                    combinedMaxLimitHolderDTOList.firstWhere(
                        (combinedMaxLimitHolderDTO) =>
                            combinedMaxLimitHolderDTO.priceConditionId ==
                                prAccSeqDetail.priceConditionId &&
                            packageId == combinedMaxLimitHolderDTO.packageId,
                        orElse: () => CombinedMaxLimitHolderDTO());
              }

              if (existingCombinedLimit.priceConditionId == 0) {
                existingCombinedLimit.packageId = packageId ?? 0;
                existingCombinedLimit.priceConditionId =
                    prAccSeqDetail.priceConditionId;
                existingCombinedLimit.availedAmount = 0.0;
                existingCombinedLimit.availedQuantity = 0;
                existingCombinedLimit.isPriceConditionAppliedForTheFirstItem =
                    true;
              }

              if (prAccSeqDetail.combinedLimitBy != null) {
                limitDTO.limitBy = prAccSeqDetail.combinedLimitBy;
              }
              if (limitDTO.limitBy == LimitBy.amount.index + 1 &&
                  prAccSeqDetail.combinedMaxValueLimit != null) {
                limitDTO.maximumLimit =
                    prAccSeqDetail.combinedMaxValueLimit ?? 0.0;
              }
              if (limitDTO.limitBy == LimitBy.quantity.index + 1 &&
                  prAccSeqDetail.combinedMaxCaseLimit != null) {
                limitDTO.maximumLimit =
                    prAccSeqDetail.combinedMaxCaseLimit ?? 0.0;
              }
            }

            if (limitDTO.limitBy != null) {
              if (limitDTO.maximumLimit != null) {
                objSingleBlock.maximumLimit = limitDTO.maximumLimit?.toDouble();
              }
              objSingleBlock.limitBy = limitDTO.limitBy;

              objSingleBlock.alreadyAvailed ??= 0.0;

              OutletAvailedPromotion? objAlreadyAvailed =
                  await pricingDao.getAlreadyAvailedPromo(
                outletId,
                prAccSeqDetail.priceConditionId,
                objSingleBlock.priceConditionDetailId,
                productDefinitionId,
                productId,
              );

              if (objAlreadyAvailed != null) {
                if (objAlreadyAvailed.amount != null) {
                  if (objSingleBlock.limitBy == LimitBy.amount.index + 1) {
                    objSingleBlock.alreadyAvailed = objAlreadyAvailed.amount!;
                  } else {
                    objSingleBlock.alreadyAvailed =
                        objAlreadyAvailed.quantity!.toDouble();
                  }
                }

                if (pcDefinitionLevelId ==
                        (EnumPCDefinitionLevel.PackageLevel.index + 1) ||
                    (conditionType.isLRB != null && conditionType.isLRB!)) {
                  // if (existingCombinedLimit?.availedAmount != null) {
                  //   (objSingleBlock.alreadyAvailed) += existingCombinedLimit?.availedAmount??0.0;
                  // }

                  if (limitDTO.limitBy == LimitBy.amount.index + 1 &&
                      existingCombinedLimit?.availedAmount != null) {
                    objSingleBlock.alreadyAvailed =
                        (objSingleBlock.alreadyAvailed ?? 0.0) +
                            (existingCombinedLimit?.availedAmount ?? 0.0);
                  } else if (limitDTO.limitBy == LimitBy.quantity.index + 1 &&
                      existingCombinedLimit?.availedQuantity != null) {
                    objSingleBlock.alreadyAvailed =
                        (objSingleBlock.alreadyAvailed ?? 0.0) +
                            (existingCombinedLimit?.availedQuantity ?? 0.0);
                  }

                  if (prAccSeqDetail.combinedLimitBy ==
                      LimitBy.amount.index + 1) {
                    objSingleBlock.maximumLimit =
                        prAccSeqDetail.combinedMaxValueLimit;
                  } else if (prAccSeqDetail.combinedLimitBy ==
                      LimitBy.quantity.index + 1) {
                    objSingleBlock.maximumLimit =
                        prAccSeqDetail.combinedMaxCaseLimit;
                  }
                }
              }
            }

            double? inputAmount;

            if (objPriceOutputDTO.priceBreakdown != null) {
              for (var unitPriceBreakDown
                  in objPriceOutputDTO.priceBreakdown!) {
                if (unitPriceBreakDown.priceConditionClassId ==
                    conditionClass.deriveFromConditionClassId) {
                  inputAmount = unitPriceBreakDown.totalPrice;
                  break;
                }
              }
            }

            inputAmount ??= totalPrice;

            var blockPrice = calculateBlockPrice(
              inputAmount,
              limitDTO.unitPrice?.toDouble(),
              quantity,
              conditionType.priceScaleBasisId,
              conditionType.operationType,
              conditionType.calculationType,
              conditionType.roundingRule,
              objSingleBlock.limitBy,
              objSingleBlock.maximumLimit,
              objSingleBlock.alreadyAvailed,
              totalPrice,
            );

            subTotal += blockPrice.blockPrice ?? 0.0;
            totalPrice = blockPrice.totalPrice ?? 0.0;
            objSingleBlock.priceConditionType = conditionType.name;
            objSingleBlock.priceConditionClass = conditionClass.name;
            objSingleBlock.priceConditionClassOrder = conditionClass.order;
            objSingleBlock.priceCondition = prAccSeqDetail.name;
            objSingleBlock.accessSequence = prAccSeqDetail.sequenceName;
            objSingleBlock.calculationType = conditionType.calculationType;
            objSingleBlock.unitPrice = limitDTO.unitPrice?.toDouble();
            objSingleBlock.blockPrice = blockPrice.blockPrice;
            objSingleBlock.totalPrice = totalPrice;

            objSingleBlock.priceConditionId = prAccSeqDetail.priceConditionId;
            objSingleBlock.productDefinitionId = productDefinitionId;
            objSingleBlock.priceConditionClassId =
                conditionClass.priceConditionClassId;

            objPriceOutputDTO.priceBreakdown?.add(objSingleBlock);
            objPriceOutputDTO.totalPrice = totalPrice;

            if (blockPrice.isMaxLimitReached ?? false) {
              Message message = Message();
              message.MessageSeverityLevel = conditionClass.severityLevel;
              message.MessageText =
                  "Max limit crossed for ${objSingleBlock.priceCondition}";
              objPriceOutputDTO.messages?.add(message);
            }

            if (existingCombinedLimit != null) {
              existingCombinedLimit.availedAmount =
                  existingCombinedLimit.availedAmount! +
                      (blockPrice.blockPrice ?? 0.0);
              if (blockPrice.actualQuantity != null) {
                existingCombinedLimit.availedQuantity =
                    existingCombinedLimit.availedQuantity! +
                        blockPrice.actualQuantity!;
              }
              if (existingCombinedLimit
                  .isPriceConditionAppliedForTheFirstItem!) {
                existingCombinedLimit.isPriceConditionAppliedForTheFirstItem =
                    false;
                combinedMaxLimitHolderDTOList.add(existingCombinedLimit);
              }
            }

            break;
          }
        }
      }

      if (!isPriceFound &&
          (conditionClass.severityLevelMessage != null &&
              conditionClass.severityLevelMessage!.isNotEmpty) &&
          conditionClass.severityLevel !=
              MessageSeverityLevel.MESSAGE.index + 1) {
        Message message = Message();
        message.MessageSeverityLevel = conditionClass.severityLevel;
        message.MessageText = conditionClass.severityLevelMessage;
        objPriceOutputDTO.messages?.add(message);
      }
    }

    objPriceOutputDTO.totalPrice = totalPrice;
    return objPriceOutputDTO;
  }

  Future<PromoLimitDTO?> getPriceAgainstPriceCondition(
      int? priceConditionId,
      String? accessSequence,
      int? outletId,
      int? productDefinitionId,
      int? quantity,
      double? totalPrice,
      int? scaleBasisId,
      int? routeId,
      int? distributionId,
      int? bundleId,
      int? channelId,
      int? packageId,
      int? pcDefinitionLevelId) async {
    PromoLimitDTO? promoLimitDTO = PromoLimitDTO();

    switch (accessSequence?.toUpperCase()) {
      case 'OUTLET_PRODUCT':
        promoLimitDTO = await getPriceAgainstOutletProduct(
            priceConditionId,
            outletId,
            productDefinitionId,
            quantity,
            totalPrice,
            scaleBasisId,
            bundleId,
            packageId,
            pcDefinitionLevelId);
        break;
      case 'ROUTE_PRODUCT':
        promoLimitDTO = await getPriceAgainstRouteProduct(
            priceConditionId,
            routeId,
            productDefinitionId,
            quantity,
            totalPrice,
            scaleBasisId,
            bundleId,
            packageId,
            pcDefinitionLevelId);
        break;
      case 'DISTRIBUTION_PRODUCT':
        promoLimitDTO = await getPriceAgainstDistributionProduct(
            priceConditionId,
            distributionId!,
            productDefinitionId,
            quantity,
            totalPrice,
            scaleBasisId,
            bundleId,
            packageId,
            pcDefinitionLevelId);
        break;
      case 'PRODUCT':
        promoLimitDTO = await getPriceAgainstProduct(
            priceConditionId,
            productDefinitionId,
            quantity,
            totalPrice,
            scaleBasisId,
            bundleId,
            packageId,
            pcDefinitionLevelId);
        break;
      case 'OUTLET':
        promoLimitDTO = await getPriceAgainstOutlet(
            priceConditionId, outletId, quantity, totalPrice, scaleBasisId);
        break;
      case 'ROUTE':
        promoLimitDTO = await getPriceAgainstRoute(
            priceConditionId, routeId, quantity, totalPrice, scaleBasisId);
        break;
      case 'DISTRIBUTION':
        promoLimitDTO = await getPriceAgainstDistribution(priceConditionId,
            distributionId!, quantity, totalPrice, scaleBasisId);
        break;
      default:
        // Handle unknown accessSequence cases if needed
        break;
    }

    return promoLimitDTO;
  }

  Future<PromoLimitDTO?> getPriceAgainstOutletProduct(
      int? priceConditionId,
      int? outletId,
      int? productDefinitionId,
      int? quantity,
      double? totalPrice,
      int? scaleBasisId,
      int? bundleId,
      int? packageId,
      int? pcDefinitionLevelId) async {
    PromoLimitDTO maxLimitDTO = PromoLimitDTO();

    PriceConditionDetailsWithScale? priceConditionDetailsWithScale =
        await conditionDetailDao
            .findPriceConditionEntityOutlet(
                priceConditionId, outletId, bundleId)
            .then((priceConditionEntities) => getPriceConditionDetailObservable(
                priceConditionEntities,
                priceConditionId,
                productDefinitionId,
                bundleId,
                packageId));

    if (priceConditionDetailsWithScale == null) {
      return null;
    }

    PriceConditionDetail? detail =
        priceConditionDetailsWithScale.priceConditionDetail;
    if (detail != null) {
      maxLimitDTO.priceConditionDetailId = (detail.priceConditionDetailId);
      maxLimitDTO.limitBy = detail.limitBy;
      maxLimitDTO.maximumLimit = detail.maximumLimit ?? 0.0;

      Product? unitProduct =
          await productDao.checkUnitProduct(productDefinitionId);
      bool isProductUnit = unitProduct != null;

      if (pcDefinitionLevelId ==
              (EnumPCDefinitionLevel.PackageLevel.index + 1) &&
          !isProductUnit) {
        if (priceConditionDetailsWithScale.priceConditionScaleList == null ||
            priceConditionDetailsWithScale.priceConditionScaleList!.isEmpty) {
          if (detail.cartonAmount != null) {
            maxLimitDTO.unitPrice = detail.cartonAmount ?? 0.0;
          }
        } else {
          maxLimitDTO.unitPrice = getScaledAmount(
                  priceConditionDetailsWithScale.priceConditionScaleList,
                  detail.priceConditionDetailId,
                  scaleBasisId,
                  quantity,
                  totalPrice,
                  true) ??
              0.0;
        }
      } else {
        if (priceConditionDetailsWithScale.priceConditionScaleList == null ||
            priceConditionDetailsWithScale.priceConditionScaleList!.isEmpty) {
          maxLimitDTO.unitPrice = detail.amount ?? 0;
        } else {
          maxLimitDTO.unitPrice = getScaledAmount(
                  priceConditionDetailsWithScale.priceConditionScaleList,
                  detail.priceConditionDetailId,
                  scaleBasisId,
                  quantity,
                  totalPrice,
                  false) ??
              0.0;
        }
      }
    }

    return maxLimitDTO;
  }

  Future<PromoLimitDTO> getPriceAgainstRouteProduct(
      int? priceConditionId,
      int? routeId,
      int? productDefinitionId,
      int? quantity,
      double? totalPrice,
      int? scaleBasisId,
      int? bundleId,
      int? packageId,
      int? pcDefinitionLevelId) async {
    PromoLimitDTO maxLimitDTO = PromoLimitDTO();

    PriceConditionDetailsWithScale? priceConditionDetail =
        await conditionDetailDao
            .findPriceConditionEntityRoute(priceConditionId, routeId, bundleId)
            .then((priceConditionEntities) => getPriceConditionDetailObservable(
                priceConditionEntities,
                priceConditionId,
                productDefinitionId,
                bundleId,
                packageId));

    if (priceConditionDetail != null) {
      PriceConditionDetail? detail = priceConditionDetail.priceConditionDetail;
      maxLimitDTO.priceConditionDetailId = detail?.priceConditionDetailId;
      maxLimitDTO.limitBy = detail?.limitBy;
      maxLimitDTO.maximumLimit = detail?.maximumLimit ?? 0.0;

      Product? unitProduct =
          await productDao.checkUnitProduct(productDefinitionId);
      bool isProductUnit = unitProduct != null;

      if (pcDefinitionLevelId ==
              (EnumPCDefinitionLevel.PackageLevel.index + 1) &&
          !isProductUnit) {
        if (priceConditionDetail.priceConditionScaleList == null ||
            priceConditionDetail.priceConditionScaleList!.isEmpty) {
          if (detail?.cartonAmount != null) {
            maxLimitDTO.unitPrice = detail?.cartonAmount ?? 0.0;
          }
        } else {
          maxLimitDTO.unitPrice = getScaledAmount(
                  priceConditionDetail.priceConditionScaleList,
                  detail?.priceConditionDetailId,
                  scaleBasisId,
                  quantity,
                  totalPrice,
                  true) ??
              0.0;
        }
      } else {
        if (priceConditionDetail.priceConditionScaleList == null ||
            priceConditionDetail.priceConditionScaleList!.isEmpty) {
          maxLimitDTO.unitPrice = detail?.amount ?? 0.0;
        } else {
          maxLimitDTO.unitPrice = getScaledAmount(
                  priceConditionDetail.priceConditionScaleList,
                  detail?.priceConditionDetailId,
                  scaleBasisId,
                  quantity,
                  totalPrice,
                  false) ??
              0.0;
        }
      }
    }

    return maxLimitDTO;
  }

  Future<PromoLimitDTO> getPriceAgainstDistributionProduct(
      int? priceConditionId,
      int? distributionId,
      int? productDefinitionId,
      int? quantity,
      double? totalPrice,
      int? scaleBasisId,
      int? bundleId,
      int? packageId,
      int? pcDefinitionLevelId) async {
    PromoLimitDTO maxLimitDTO = PromoLimitDTO();

    PriceConditionDetailsWithScale? priceConditionDetail =
        await conditionDetailDao
            .findPriceConditionEntityDistribution(
                priceConditionId, distributionId, bundleId)
            .then((priceConditionEntities) => getPriceConditionDetailObservable(
                priceConditionEntities,
                priceConditionId,
                productDefinitionId,
                bundleId,
                packageId));

    if (priceConditionDetail != null) {
      PriceConditionDetail? detail = priceConditionDetail.priceConditionDetail;
      maxLimitDTO.priceConditionDetailId = detail?.priceConditionDetailId;
      maxLimitDTO.limitBy = detail?.limitBy;
      maxLimitDTO.maximumLimit = detail?.maximumLimit ?? 0.0;

      Product? unitProduct =
          await productDao.checkUnitProduct(productDefinitionId);
      bool isProductUnit = unitProduct != null;

      if (pcDefinitionLevelId ==
              (EnumPCDefinitionLevel.PackageLevel.index + 1) &&
          !isProductUnit) {
        if (priceConditionDetail.priceConditionScaleList == null ||
            priceConditionDetail.priceConditionScaleList!.isEmpty) {
          if (detail?.cartonAmount != null) {
            maxLimitDTO.unitPrice = detail?.cartonAmount ?? 0.0;
          }
        } else {
          maxLimitDTO.unitPrice = getScaledAmount(
                  priceConditionDetail.priceConditionScaleList,
                  detail?.priceConditionDetailId,
                  scaleBasisId,
                  quantity,
                  totalPrice,
                  true) ??
              0.0;
        }
      } else {
        if (priceConditionDetail.priceConditionScaleList == null ||
            priceConditionDetail.priceConditionScaleList!.isEmpty) {
          maxLimitDTO.unitPrice = detail?.amount ?? 0.0;
        } else {
          maxLimitDTO.unitPrice = getScaledAmount(
                  priceConditionDetail.priceConditionScaleList,
                  detail?.priceConditionDetailId,
                  scaleBasisId,
                  quantity,
                  totalPrice,
                  false) ??
              0.0;
        }
      }
    }

    return maxLimitDTO;
  }

  Future<PromoLimitDTO> getPriceAgainstProduct(
      int? priceConditionId,
      int? productDefinitionId,
      int? quantity,
      double? totalPrice,
      int? scaleBasisId,
      int? bundleId,
      int? packageId,
      int? pcDefinitionLevelId) async {
    PromoLimitDTO maxLimitDTO = PromoLimitDTO();

    PriceConditionDetailsWithScale? priceConditionDetailsWithScale =
        await conditionDetailDao.findPriceConditionDetailWithBundle(
            priceConditionId, productDefinitionId, bundleId, packageId);

    if (priceConditionDetailsWithScale == null) return maxLimitDTO;

    PriceConditionDetail? detail =
        priceConditionDetailsWithScale.priceConditionDetail;
    if (detail != null) {
      maxLimitDTO.priceConditionDetailId = detail.priceConditionDetailId;
      maxLimitDTO.limitBy = detail.limitBy;
      maxLimitDTO.maximumLimit = detail.maximumLimit ?? 0.0;

      Product? unitProduct =
          await productDao.checkUnitProduct(productDefinitionId);
      bool isProductUnit = unitProduct != null;

      if (pcDefinitionLevelId ==
              (EnumPCDefinitionLevel.PackageLevel.index + 1) &&
          !isProductUnit) {
        if (priceConditionDetailsWithScale.priceConditionScaleList == null ||
            priceConditionDetailsWithScale.priceConditionScaleList!.isEmpty) {
          if (detail.cartonAmount != null) {
            maxLimitDTO.unitPrice = detail.cartonAmount ?? 0.0;
          }
        } else {
          maxLimitDTO.unitPrice = getScaledAmount(
                  priceConditionDetailsWithScale.priceConditionScaleList,
                  detail.priceConditionDetailId,
                  scaleBasisId,
                  quantity,
                  totalPrice,
                  true) ??
              0.0;
        }
      } else {
        if (priceConditionDetailsWithScale.priceConditionScaleList == null ||
            priceConditionDetailsWithScale.priceConditionScaleList!.isEmpty) {
          maxLimitDTO.unitPrice = detail.amount ?? 0.0;
        } else {
          maxLimitDTO.unitPrice = getScaledAmount(
                  priceConditionDetailsWithScale.priceConditionScaleList,
                  detail.priceConditionDetailId,
                  scaleBasisId,
                  quantity,
                  totalPrice,
                  false) ??
              0.0;
        }
      }
    }

    return maxLimitDTO;
  }

  Future<OrderResponseModel> getFreeGoods(
      OrderResponseModel orderVM, String date) async {
    try {
      if (orderVM.outletId != null && orderVM.outletId! > 0) {
        List<ProductQuantity> productList = [];

        List<OrderDetail> paidOrderDetails = [];

        if (orderVM.orderDetails != null) {
          List<OrderDetail> orderDetails = orderVM.orderDetails!.map(
                (e) => OrderDetail.fromJson(e.toJson()),
          )
              .toList();
          for (OrderDetail orderDetail in orderDetails) {
            if (orderDetail.type == "paid") {
              paidOrderDetails.add(orderDetail);

              ProductQuantity productQuantity = ProductQuantity();
              productQuantity.productDefinitionId =
                  orderDetail.productTempDefinitionId;
              productQuantity.quantity = orderDetail.productTempQuantity;
              productQuantity.packageId = orderDetail.packageId;
              productList.add(productQuantity);
            }
          }
        }

        List<int> appliedFreeGoodGroupIds = [];
        for (OrderDetail orderDetail in paidOrderDetails) {
          Product? isParentUnitProduct = await productDao
              .checkUnitProduct(orderDetail.productTempDefinitionId);

          int optionalFreeGoodCount = 0;

          List<FreeGoodOutputDTO> freeGoodOutputDTOS = await _getFreeGoods(
            orderVM.outletId,
            orderVM.channelId,
            orderVM.outlet?.vpoClassificationId,
            orderVM.outlet?.pricingGroupId,
            orderVM.routeId,
            orderVM.distributionId,
            orderDetail.productTempDefinitionId,
            productList,
            appliedFreeGoodGroupIds,
            date,
          );

          for (FreeGoodOutputDTO freegood in freeGoodOutputDTOS) {
            freegood.parentId = orderDetail.orderDetailId;
            if (freegood.freeGoodGroupId != null) {
              appliedFreeGoodGroupIds.add(freegood.freeGoodGroupId!);
            }

            OrderDetail childOrderDetail = OrderDetail();
            childOrderDetail.mProductName = freegood.productName;
            childOrderDetail.productTempDefinitionId =
                freegood.productDefinitionId;
            childOrderDetail.mProductId = freegood.productId;

            childOrderDetail.type = "freegood";

            if (freegood.freeQuantityTypeId ==
                EnumFreeGoodsQuantityType.Optional.index + 1) {
              optionalFreeGoodCount++;
            }

            Product? isChildUnitProduct =
                await productDao.checkUnitProduct(freegood.productDefinitionId);

            if (isChildUnitProduct == null) {
              // child is carton
              childOrderDetail.cartonDefinitionId =
                  freegood.productDefinitionId;
              childOrderDetail.mCartonQuantity =
                  freegood.finalFreeGoodsQuantity;
              childOrderDetail.actualCartonStock = freegood.stockInHand;
              if (freegood.freeGoodGroupId != null) {
                childOrderDetail.cartonFreeGoodGroupId =
                    freegood.freeGoodGroupId;
              }
              if (freegood.freeGoodDetailId != null) {
                childOrderDetail.cartonFreeGoodDetailId =
                    freegood.freeGoodDetailId;
              }
              if (freegood.freeGoodExclusiveId != null) {
                childOrderDetail.cartonFreeGoodExclusiveId =
                    freegood.freeGoodExclusiveId;
              }
              childOrderDetail.cartonFreeQuantityTypeId =
                  freegood.freeQuantityTypeId;
              childOrderDetail.cartonFreeGoodQuantity =
                  freegood.finalFreeGoodsQuantity;
              childOrderDetail.mCartonCode = freegood.definitionCode;
            } else {
              // child is unit
              childOrderDetail.mUnitCode = freegood.definitionCode;
              childOrderDetail.unitDefinitionId = freegood.productDefinitionId;
              childOrderDetail.mUnitQuantity = freegood.finalFreeGoodsQuantity;
              childOrderDetail.actualUnitStock = freegood.stockInHand;

              if (freegood.freeGoodGroupId != null) {
                childOrderDetail.unitFreeGoodGroupId = freegood.freeGoodGroupId;
              }

              if (freegood.freeGoodDetailId != null) {
                childOrderDetail.unitFreeGoodDetailId =
                    freegood.freeGoodDetailId;
              }

              if (freegood.freeGoodExclusiveId != null) {
                childOrderDetail.unitFreeGoodExclusiveId =
                    freegood.freeGoodExclusiveId;
              }

              childOrderDetail.unitFreeQuantityTypeId =
                  freegood.freeQuantityTypeId;
              childOrderDetail.unitFreeGoodQuantity =
                  freegood.finalFreeGoodsQuantity;
            }

            if (isParentUnitProduct == null) {
              // Parent is carton
              if (orderDetail.mCartonOrderDetailId != null) {
                childOrderDetail.parentId =
                    orderDetail.mCartonOrderDetailId?.toInt();
              }

              List<OrderDetail>? cartonFreeGoods = orderDetail.cartonFreeGoods;
              cartonFreeGoods?.add(childOrderDetail);
              orderDetail.cartonFreeGoods = cartonFreeGoods;
            } else {
              // Parent is unit
              if (orderDetail.mUnitOrderDetailId != null) {
                childOrderDetail.parentId =
                    orderDetail.mUnitOrderDetailId?.toInt();
              }

              List<OrderDetail>? unitFreeGoods = orderDetail.unitFreeGoods;
              unitFreeGoods?.add(childOrderDetail);
              orderDetail.unitFreeGoods = unitFreeGoods;
            }
          }

          if (optionalFreeGoodCount > 0) {
            if (isParentUnitProduct == null) {
              orderDetail.cartonFreeQuantityTypeId =
                  EnumFreeGoodsQuantityType.Optional.index + 1;
              if (freeGoodOutputDTOS.isNotEmpty) {
                orderDetail.cartonFreeGoodQuantity =
                    freeGoodOutputDTOS[0].freeGoodQuantity;
              }
            } else {
              orderDetail.unitFreeQuantityTypeId =
                  EnumFreeGoodsQuantityType.Optional.index + 1;
              if (freeGoodOutputDTOS.isNotEmpty) {
                orderDetail.unitFreeGoodQuantity =
                    freeGoodOutputDTOS[0].freeGoodQuantity;
              }
            }
          } else {
            if (isParentUnitProduct == null) {
              orderDetail.cartonFreeQuantityTypeId =
                  EnumFreeGoodsQuantityType.Primary.index + 1;
            } else {
              orderDetail.unitFreeQuantityTypeId =
                  EnumFreeGoodsQuantityType.Primary.index + 1;
            }
          }
        }

        return orderVM;
      } else {
        return orderVM;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<FreeGoodOutputDTO>> _getFreeGoods(
    int? outletId,
    int? channelId,
    int? vpoClassficationId,
    int? pricingGroupId,
    int? routeId,
    int? distributionId,
    int? productDefinitionId,
    List<ProductQuantity>? productList,
    List<int>? appliedFreeGoodGroupIds,
    String? date,
  ) async {
    List<PriceAccessSequence> priceAccessSequence =
        await pricingDao.getAccessSequenceByTypeId();

    List<FreeGoodOutputDTO> freeGoodDTOList = [];
    List<FreeGoodGroups> appliedFreeGoodGroups = [];

    for (PriceAccessSequence sequence in priceAccessSequence) {
      if (sequence.sequenceCode?.toLowerCase() ==
          AccessSequenceCode.OUTLET_PRODUCT.toString().toLowerCase()) {
        appliedFreeGoodGroups = await pricingDao.appliedFreeGoodGroups(
            outletId,
            channelId,
            vpoClassficationId,
            pricingGroupId,
            0,
            0,
            productDefinitionId,
            sequence.priceAccessSequenceId,
            outletId);
      } else if (sequence.sequenceCode?.toLowerCase() ==
          AccessSequenceCode.ROUTE_PRODUCT.toString().toLowerCase()) {
        appliedFreeGoodGroups = await pricingDao.appliedFreeGoodGroups(
            0,
            channelId,
            vpoClassficationId,
            pricingGroupId,
            routeId,
            0,
            productDefinitionId,
            sequence.priceAccessSequenceId,
            outletId);
      } else if (sequence.sequenceCode?.toLowerCase() ==
          AccessSequenceCode.DISTRIBUTION_PRODUCT.toString().toLowerCase()) {
        appliedFreeGoodGroups = await pricingDao.appliedFreeGoodGroups(
            0,
            channelId,
            vpoClassficationId,
            pricingGroupId,
            0,
            distributionId,
            productDefinitionId,
            sequence.priceAccessSequenceId,
            outletId);
      } else if (sequence.sequenceCode?.toLowerCase() ==
          AccessSequenceCode.PRODUCT.toString().toLowerCase()) {
        appliedFreeGoodGroups = await pricingDao.appliedFreeGoodGroups(
            0,
            channelId,
            vpoClassficationId,
            pricingGroupId,
            0,
            0,
            productDefinitionId,
            sequence.priceAccessSequenceId,
            outletId);
      }

      List<FreeGoodGroups> prfreeGoodsList = [];

      for (FreeGoodGroups freeGoodGroups in appliedFreeGoodGroups) {
        if (freeGoodGroups.id != null) {
          int bundleProductsQuantitySum = 0,
              freeGoodDetailsCount = 0,
              freeGoodOrderedProductCount = 0;

          freeGoodDetailsCount =
              await pricingDao.getFreeGoodDetailCount(freeGoodGroups.id);

          List<FreeGoodDetails> freeGoodDetails =
              await pricingDao.getFreeGoodDetail(freeGoodGroups.id);

          freeGoodOrderedProductCount = 0;
          int maximumQuantity =
              await pricingDao.getFreeGoodGroupMaxQuantity(freeGoodGroups.id);

          if (productList != null) {
            for (ProductQuantity productQuantity in productList) {
              for (FreeGoodDetails freeGoodDetails1 in freeGoodDetails) {
                if (productQuantity.productDefinitionId ==
                    freeGoodDetails1.productDefinitionId) {
                  freeGoodOrderedProductCount++;
                }
              }
            }
          }

          if (freeGoodDetailsCount == freeGoodOrderedProductCount) {
            int bundleProductsQuantitySum = 0;

            if (productList != null) {
              for (ProductQuantity productQuantity in productList) {
                for (FreeGoodDetails freeGoodDetails1 in freeGoodDetails) {
                  if (productQuantity.productDefinitionId ==
                      freeGoodDetails1.productDefinitionId) {
                    bundleProductsQuantitySum = bundleProductsQuantitySum +
                        (productQuantity.quantity ?? 0);
                  }
                }
              }
            }

            if (bundleProductsQuantitySum >=
                    (freeGoodGroups.minimumQuantity ?? 0) &&
                (freeGoodGroups.channelAttributeCount == 0 ||
                    freeGoodGroups.outletChannelAttributeCount! > 0) &&
                (freeGoodGroups.groupAttributeCount == 0 ||
                    freeGoodGroups.outletGroupAttributeCount! > 0) &&
                (freeGoodGroups.vpoAttributeCount == 0 ||
                    freeGoodGroups.outletVPOAttributeCount! > 0)) {
              prfreeGoodsList.add(freeGoodGroups);
            }
          }
        }
      }

      if (prfreeGoodsList.isNotEmpty) {
        int alreadyApplied = 0;

        OUTER:
        if (appliedFreeGoodGroupIds != null) {
          for (int appliedGoods in appliedFreeGoodGroupIds) {
            for (FreeGoodGroups prGetFreeGoods in prfreeGoodsList) {
              if (appliedGoods == prGetFreeGoods.id) {
                alreadyApplied++;
                break OUTER;
              }
            }
          }
        }

        if (alreadyApplied == 0) {
          FreeGoodGroups? promo;

          if (prfreeGoodsList.isNotEmpty) promo = prfreeGoodsList[0];

          List<FreeGoodOutputDTO> freeGoodOutputList =
              await getAvailableFreeGoods(promo, productList, outletId, 0);

          freeGoodDTOList.addAll(freeGoodOutputList);
          break;
        } else {
          break;
        }
      }
    }

    return freeGoodDTOList;
  }

  Future<List<FreeGoodOutputDTO>> getAvailableFreeGoods(
      FreeGoodGroups? freeGood,
      List<ProductQuantity>? productList,
      int? outletId,
      int? orderId) async {
    List<FreeGoodOutputDTO> freeGoodOutputList = [];
    int totalOrderedPromoQuantity = 0;

    if (freeGood != null) {
      if (freeGood.typeId == EnumFreeGoodsType.Inclusive.index + 1) {
        freeGoodOutputList =
            await pricingDao.getFreeGoodGroupDetails(freeGood.id);

        if (productList != null) {
          for (var productQuantity in productList) {
            for (var freeGoodOutputDTO in freeGoodOutputList) {
              if (productQuantity.productDefinitionId ==
                  freeGoodOutputDTO.productDefinitionId) {
                totalOrderedPromoQuantity =
                    totalOrderedPromoQuantity + (productQuantity.quantity ?? 0);
              }
            }
          }
        }
      } else if (freeGood.typeId == EnumFreeGoodsType.Exclusive.index + 1) {
        if (freeGood.freeQuantityTypeId ==
            EnumFreeGoodsQuantityType.Primary.index + 1) {
          freeGoodOutputList =
              await pricingDao.getFreeGoodExclusiveDetails(freeGood.id);

          for (var freeGoodOutputDTO in freeGoodOutputList) {
            freeGoodOutputDTO.freeGoodTypeId = freeGood.typeId;
            freeGoodOutputDTO.forEachQuantity = freeGood.forEachQuantity;
          }
        } else if (freeGood.freeQuantityTypeId ==
            EnumFreeGoodsQuantityType.Optional.index + 1) {
          freeGoodOutputList =
              await pricingDao.getFreeGoodExclusiveDetails(freeGood.id);

          for (var freeGoodOutputDTO in freeGoodOutputList) {
            freeGoodOutputDTO.freeGoodTypeId = freeGood.typeId;
            freeGoodOutputDTO.forEachQuantity = freeGood.forEachQuantity;
          }
        }

        List<int> promoBaseProducts =
            await pricingDao.getPromoBaseProduct(freeGood.id);

        if (productList != null) {
          for (var productQuantity in productList) {
            for (var promo in promoBaseProducts) {
              if (productQuantity.productDefinitionId == promo) {
                totalOrderedPromoQuantity =
                    totalOrderedPromoQuantity + (productQuantity.quantity ?? 0);
              }
            }
          }
        }
      }
    }

    if (freeGoodOutputList.isNotEmpty) {
      for (var item in freeGoodOutputList) {
        item.freeQuantityTypeId = freeGood?.freeQuantityTypeId;
        int alreadyAvailedFreeGoods =
            await pricingDao.getAlreadyAvailedFreeGoods(item.freeGoodGroupId,
                item.freeGoodDetailId, item.freeGoodExclusiveId, outletId);
        getFinalFreeGoodQuantity(
            item, totalOrderedPromoQuantity, alreadyAvailedFreeGoods);
      }
    }

    return freeGoodOutputList;
  }

  FreeGoodOutputDTO getFinalFreeGoodQuantity(FreeGoodOutputDTO freegood,
      int totalOrderedPromoQuantity, int alreadyAvailedFreeGoods) {
    if (freegood.forEachQuantity != null && freegood.forEachQuantity! > 0) {
      freegood.qualifiedFreeGoodQuantity =
          (((totalOrderedPromoQuantity / (freegood.forEachQuantity ?? 1))) *
                  (freegood.freeGoodQuantity ?? 1))
              .toInt();
    }
    freegood.finalFreeGoodsQuantity = freegood.qualifiedFreeGoodQuantity;

    alreadyAvailedFreeGoods ??= 0;

    int? remainingMaxQuantity = freegood.finalFreeGoodsQuantity;
    if (freegood.maximumFreeGoodQuantity != null &&
        freegood.maximumFreeGoodQuantity != 0) {
      remainingMaxQuantity =
          freegood.maximumFreeGoodQuantity! - alreadyAvailedFreeGoods;
    }

    if ((freegood.finalFreeGoodsQuantity ?? 0) > (remainingMaxQuantity ?? 0)) {
      freegood.finalFreeGoodsQuantity = remainingMaxQuantity;
      Message message = Message(
        MessageText:
            "The Order Qualified for the ${freegood.qualifiedFreeGoodQuantity} items as FOC but you are getting your remaining Max. FOC for the promotion(${freegood.finalFreeGoodsQuantity}).",
      );

      freegood.messages ??= [];
      freegood.messages?.add(message);
    }
    return freegood;
  }

  Future<void> addProductQty(List<ProductQuantity> productQuantities) {
    return pricingDao.insertTempOrderQty(productQuantities);
  }

  Future<List<int>> getBundlesList(int? productDefId, int? conditionTypeId) {
    return pricingDao.getBundleIdsForConditionType(
        productDefId, conditionTypeId);
  }

  Future<List<int>> getBundlesToApply(List<int> bundleIds) async {
    List<int> bundlesHolder = [];
    for (int bundleId in bundleIds) {
      int minimumQty = await pricingDao.getBundleMinQty(bundleId);
      int bundleProductCount = await pricingDao.getBundleProductCount(bundleId);
      int calculatedBundleProdCount =
          await pricingDao.getCalculatedBundleProdCount(bundleId);
      int bundleProdTotalQty = await pricingDao.getBundleProdTotalQty(bundleId);
      if ((minimumQty == 0 || minimumQty <= bundleProdTotalQty) &&
          (calculatedBundleProdCount == bundleProductCount) &&
          (calculatedBundleProdCount > 0)) {
        bundlesHolder.add(bundleId);
      }
    }

    return bundlesHolder;
  }

  Future<PriceConditionDetailsWithScale?> getPriceConditionDetailObservable(
      PriceConditionEntities? priceConditionEntity,
      int? priceConditionId,
      int? productDefinitionId,
      int? bundleId,
      int? packageId) async {
    if (priceConditionEntity == null) {
      return null;
    }

    return conditionDetailDao.findPriceConditionDetailWithBundle(
        priceConditionId, productDefinitionId, bundleId, packageId);
  }
}
