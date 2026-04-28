import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/expense_controller.dart';
import 'expense_detail_view.dart';
import 'category_manage_view.dart';

class ExpenseListView extends StatelessWidget {
  final ExpenseController controller = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Quản lý chi tiêu", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Nguyễn Hoàng Tuấn Đạt - 6451071014", style: TextStyle(fontSize: 14)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.category), onPressed: () => Get.to(() => CategoryManageView())),
        ],
      ),
      body: Column(
        children: [
          // Widget hiển thị tổng tiền
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Obx(() => Column(
              children: [
                Text("TỔNG CHI TIÊU", style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold)),
                Text("${controller.grandTotal.toStringAsFixed(0)} VNĐ", 
                     style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            )),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.expenses.length,
              itemBuilder: (context, index) {
                final item = controller.expenses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(item.categoryName![0])),
                    title: Text(item.note),
                    subtitle: Text(item.categoryName!),
                    trailing: Text("-${item.amount.toStringAsFixed(0)}đ", 
                                   style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    onLongPress: () => controller.deleteExpense(item.id!),
                  ),
                );
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.categories.isEmpty) {
            Get.snackbar("Lưu ý", "Hãy tạo danh mục chi tiêu trước!");
          } else {
            Get.to(() => ExpenseDetailView());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}