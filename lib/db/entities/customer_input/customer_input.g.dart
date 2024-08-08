// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerInput _$CustomerInputFromJson(Map<String, dynamic> json) {
  return CustomerInput(
    outletId: json['outletId'] as int?,
    orderId: json['orderId'] as int?,
    mobileNumber: json['mobileNumber'] as String?,
    strn: json['strn'] as String?,
    remarks: json['remarks'] as String?,
    signature: json['signature'] as String?,
    cnic: json['cnic'] as String?,
    deliveryDate: json['deliveryDate'] as int?,
  );
}

Map<String, dynamic> _$CustomerInputToJson(CustomerInput instance) =>
    <String, dynamic>{
      'outletId': instance.outletId,
      'orderId': instance.orderId,
      'mobileNumber': instance.mobileNumber,
      'strn': instance.strn,
      'remarks': instance.remarks,
      'signature': instance.signature,
      'cnic': instance.cnic,
      'deliveryDate': instance.deliveryDate,
    };
