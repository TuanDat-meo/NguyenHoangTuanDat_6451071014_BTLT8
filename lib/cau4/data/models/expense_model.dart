class ExpenseModel {
  final int? id;
  final double amount;
  final String note;
  final int categoryId;
  final String? categoryName; // Để hiển thị tên danh mục

  ExpenseModel({this.id, required this.amount, required this.note, required this.categoryId, this.categoryName});

  Map<String, dynamic> toMap() => {
    'id': id,
    'amount': amount,
    'note': note,
    'categoryId': categoryId,
  };

  factory ExpenseModel.fromMap(Map<String, dynamic> map) => ExpenseModel(
    id: map['id'],
    amount: map['amount'],
    note: map['note'],
    categoryId: map['categoryId'],
    categoryName: map['category_name'],
  );
}