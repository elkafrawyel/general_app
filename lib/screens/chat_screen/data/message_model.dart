class MessageModel {
  MessageModel({
    this.title,
    this.creationDate,
  });

  MessageModel.fromJson(dynamic json) {
    title = json['title'];
    creationDate = json['creationDate'];
  }

  String? title;
  String? creationDate;
  bool isCurrentUser = true;

  @override
  String toString() {
    return creationDate ?? '';
  }
}
