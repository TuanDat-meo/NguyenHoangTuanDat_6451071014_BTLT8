class NoteModel {
  final int? id;
  final String title;
  final String content;

  NoteModel({this.id, required this.title, required this.content});

  // Chuyển Object thành Map để lưu vào SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  // Chuyển Map từ SQLite thành Object
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}