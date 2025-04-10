class NoteModel {
  int? id;
  String? title;
  String? body;
  bool isCritical;

  NoteModel({
    this.id,
    this.title,
    this.body,
    this.isCritical = false,
  });

  NoteModel.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
        title = map['title'],
        body = map['body'],
        isCritical = map['isCritical'] == 1;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'isCritical': isCritical ? 1 : 0,
    };
  }
}
