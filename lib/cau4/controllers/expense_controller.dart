import 'package:get/get.dart';
import '../data/models/expense_model.dart';
import '../data/models/category_model.dart';
import '../data/repository/expense_repository.dart';

class ExpenseController extends GetxController {
  final ExpenseRepository _repository = ExpenseRepository();
  
  var expenses = <ExpenseModel>[].obs;
  var categories = <CategoryModel>[].obs;
  var totalsByCategory = <String, double>{}.obs;

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  Future<void> refreshData() async {
    categories.assignAll(await _repository.getAllCategories());
    expenses.assignAll(await _repository.getAllExpenses());
    totalsByCategory.assignAll(await _repository.getTotalByCategory());
  }

  void addCategory(String name) async {
    await _repository.insertCategory(CategoryModel(name: name));
    refreshData();
  }

  void addExpense(double amount, String note, int categoryId) async {
    await _repository.insertExpense(ExpenseModel(amount: amount, note: note, categoryId: categoryId));
    refreshData();
  }

  void deleteExpense(int id) async {
    await _repository.deleteExpense(id);
    refreshData();
  }

  double get grandTotal => expenses.fold(0, (sum, item) => sum + item.amount);
}