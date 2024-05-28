part of 'key_value.dart';

KeyValue _$KeyValueFromJson(Map<String, dynamic> json) {
  return KeyValue(
    key: json['key'] as int?,
    value: json['value'] as String?,
    description: json['description'] as String?,
    firstIntExtraField: json['firstIntExtraField'] as int?,
    firstStringExtraField: json['firstStringExtraField'] as String?,
    defaultFlag: json['defaultFlag'] as bool?,
    secondIntExtraField: json['secondIntExtraField'] as int?,
    secondStringExtraField: json['secondStringExtraField'] as String?,
    hasError: boolFromInt(json['hasError'] as int?),
    errorMessage: json['errorMessage'] as String?,
    quantity: json['quantity'] as int?,
    minValue: json['minValue'] as int?,
    maxValue: json['maxValue'] as int?,
  );
}

Map<String, dynamic> _$KeyValueToJson(KeyValue instance) {
  final Map<String, dynamic> data = <String, dynamic>{
    'key': instance.key,
    'value': instance.value,
    'description': instance.description,
    'firstIntExtraField': instance.firstIntExtraField,
    'firstStringExtraField': instance.firstStringExtraField,
    'defaultFlag': instance.defaultFlag,
    'secondIntExtraField': instance.secondIntExtraField,
    'secondStringExtraField': instance.secondStringExtraField,
    'hasError': boolToInt(instance.hasError),
    'errorMessage': instance.errorMessage,
    'quantity': instance.quantity,
    'minValue': instance.minValue,
    'maxValue': instance.maxValue,
  };
  return data;
}
