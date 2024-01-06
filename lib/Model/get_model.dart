class GetModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  GetModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  GetModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }
  Map<String, dynamic> toJson() {
    return {"userId": userId, "id": id, "title": title, "completed": completed};
  }
}
