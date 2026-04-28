import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/expense_controller.dart';

class CategoryManageView extends StatelessWidget {
  final ExpenseController controller = Get.find();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý danh mục chi tiêu"),
      ),
      body: Column(
        children: [
          // Phần nhập tên danh mục mới
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Ví dụ: Ăn uống, Xăng xe...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty) {
                      controller.addCategory(nameController.text);
                      nameController.clear();
                      // Ẩn bàn phím sau khi thêm
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: const Text("Thêm"),
                )
              ],
            ),
          ),
          const Divider(),
          // Danh sách các danh mục hiện có
          Expanded(
            child: Obx(() {
              if (controller.categories.isEmpty) {
                return const Center(child: Text("Chưa có danh mục nào."));
              }
              return ListView.builder(
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final cat = controller.categories[index];
                  return ListTile(
                    leading: const Icon(Icons.label_important_outline),
                    title: Text(cat.name),
                    // Bạn có thể thêm nút xóa danh mục ở đây nếu muốn nâng cấp
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}