import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';

class CategoryManageView extends StatelessWidget {
  final NoteController controller = Get.find();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quản lý danh mục")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: nameController, decoration: const InputDecoration(hintText: "Tên danh mục mới"))),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.blue, size: 35),
                  onPressed: () {
                    if (nameController.text.isNotEmpty) {
                      controller.addCategory(nameController.text);
                      nameController.clear();
                    }
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.categories.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.label),
                title: Text(controller.categories[index].name),
              ),
            )),
          )
        ],
      ),
    );
  }
}