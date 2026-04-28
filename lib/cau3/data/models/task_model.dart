class TaskModel {
  final int? id;
  final String title;
  bool isDone;

  TaskModel({this.id, required this.title, this.isDone = false});

  // Chuyển sang Map để lưu vào SQLite (SQLite không có kiểu bool, dùng 1/0)
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'isDone': isDone ? 1 : 0,
  };

  // Chuyển từ Map (SQLite/JSON) sang Object
  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
    id: map['id'],
    title: map['title'],
    isDone: map['isDone'] == 1 || map['isDone'] == true,
  );

  // Chuyển sang Map để lưu JSON (giữ nguyên kiểu bool cho JSON chuẩn)
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isDone': isDone,
  };
}