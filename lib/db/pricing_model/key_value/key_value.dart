
import 'package:order_booking/utils/util.dart';

part 'key_value.g.dart';

class KeyValue {
  int? key;
  String? value;
  String? description;
  int? firstIntExtraField;
  String? firstStringExtraField;
  bool? defaultFlag;
  int? secondIntExtraField;
  String? secondStringExtraField;
  bool? hasError;
  String? errorMessage;
  int? quantity;
  int? minValue;
  int? maxValue;

  KeyValue({
    this.key,
    this.value,
    this.description,
    this.firstIntExtraField,
    this.firstStringExtraField,
    this.defaultFlag,
    this.secondIntExtraField,
    this.secondStringExtraField,
    this.hasError,
    this.errorMessage,
    this.quantity,
    this.minValue,
    this.maxValue,
  });

  factory KeyValue.fromJson(Map<String, dynamic> json) =>
      _$KeyValueFromJson(json);

  Map<String, dynamic> toJson() => _$KeyValueToJson(this);
}
