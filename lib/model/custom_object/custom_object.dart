class CustomObject {
  int id;
  String text;

  CustomObject(this.id, this.text);

  // Named constructor to create the object from a JSON map (optional)
  CustomObject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'];

  void setId(int id) {
    this.id = id;
  }

  void setText(String text) {
    this.text = text;
  }

  int getId() {
    return id;
  }

  String getText() {
    return text;
  }

  // Override toString method
  @override
  String toString() {
    return text;
  }

  // Method to convert the object to a JSON map (optional)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }
}
