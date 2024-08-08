
part 'message.g.dart';

class Message {
  int? MessageSeverityLevel;

  String? MessageText;

  Message({this.MessageSeverityLevel, this.MessageText});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
