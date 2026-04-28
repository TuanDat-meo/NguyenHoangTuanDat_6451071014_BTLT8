class NoteModel {
  final int? id;
  final String title;
  final String content;
  final int categoryId;
  final String? categoryName; // Dùng để hiển thị tên danh mục sau khi JOIN

  NoteModel({
    this.id, 
    required this.title, 
    required this.content, 
    required this.categoryId, 
    this.categoryName
  });

  Map<String, dynamic> toMap() => {
    'id': id, 
    'title': title, 
    'content': content, 
    'categoryId': categoryId
  };

  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
    id: map['id'],
    title: map['title'],
    content: map['content'],
    categoryId: map['categoryId'],
    categoryName: map['category_name'],
  );
}