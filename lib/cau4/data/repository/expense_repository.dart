import '../models/expense_model.dart';
import '../models/category_model.dart';
import '../services/database_service.dart';

class ExpenseRepository {
  final dbService = DatabaseService();

  // --- Expenses ---
  Future<List<ExpenseModel>> getAllExpenses() async {
    final db = await dbService.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT expenses.*, categories.name as category_name 
      FROM expenses 
      JOIN categories ON expenses.categoryId = categories.id
      ORDER BY expenses.id DESC
    ''');
    return List.generate(maps.length, (i) => ExpenseModel.fromMap(maps[i]));
  }

  Future<int> insertExpense(ExpenseModel expense) async {
    final db = await dbService.database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<int> updateExpense(ExpenseModel expense) async {
    final db = await dbService.database;
    return await db.update('expenses', expense.toMap(), where: 'id = ?', whereArgs: [expense.id]);
  }

  Future<int> deleteExpense(int id) async {
    final db = await dbService.database;
    return await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }

  // --- Categories ---
  Future<List<CategoryModel>> getAllCategories() async {
    final db = await dbService.database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) => CategoryModel.fromMap(maps[i]));
  }

  Future<int> insertCategory(CategoryModel category) async {
    final db = await dbService.database;
    return await db.insert('categories', category.toMap());
  }

  // --- Aggregate: Tính tổng theo danh mục ---
  Future<Map<String, double>> getTotalByCategory() async {
    final db = await dbService.database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT categories.name, SUM(expenses.amount) as total
      FROM expenses
      JOIN categories ON expenses.categoryId = categories.id
      GROUP BY categories.id
    ''');
    
    Map<String, double> totals = {};
    for (var row in result) {
      totals[row['name'] as String] = (row['total'] as num).toDouble();
    }
    return totals;
  }
}