import 'package:json_annotation/json_annotation.dart';

part 'customer_input.g.dart';

@JsonSerializable()
class CustomerInput {
  @JsonKey(name: 'outletId')
  final int? outletId;

  @JsonKey(name: 'orderId')
  final int? orderId;

  @JsonKey(name: 'mobileNumber')
  final String? mobileNumber;

  @JsonKey(name: 'strn')
  final String? strn;

  @JsonKey(name: 'remarks')
  final String? remarks;

  @JsonKey(name: 'signature')
  final String? signature;

  @JsonKey(name: 'cnic')
  final String? cnic;

  @JsonKey(name: 'deliveryDate')
  final int? deliveryDate;

  CustomerInput({
    this.outletId,
    this.orderId,
    this.mobileNumber,
    this.strn,
    this.remarks,
    this.signature,
    this.cnic,
    this.deliveryDate,
  });

  factory CustomerInput.fromJson(Map<String, dynamic> json) =>
      _$CustomerInputFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerInputToJson(this);
}
