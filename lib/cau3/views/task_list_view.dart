import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class TaskListView extends StatelessWidget {
  final TaskController controller = Get.put(TaskController());
  final TextEditingController taskInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("To-Do List & JSON Backup", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("Nguyễn Hoàng Tuấn Đạt - 6451071014", style: TextStyle(fontSize: 14)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.upload_file), onPressed: controller.exportToJson, tooltip: "Export JSON"),
          IconButton(icon: const Icon(Icons.download), onPressed: controller.importFromJson, tooltip: "Import JSON"),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskInputController,
                    decoration: const InputDecoration(hintText: "Nhập công việc mới...", border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    controller.addTask(taskInputController.text);
                    taskInputController.clear();
                  },
                  child: const Text("Thêm"),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Obx(() {
              if (controller.tasks.isEmpty) return const Center(child: Text("Danh sách trống"));
              return ListView.builder(
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  final task = controller.tasks[index];
                  return CheckboxListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isDone ? TextDecoration.lineThrough : null,
                        color: task.isDone ? Colors.grey : Colors.black,
                      ),
                    ),
                    value: task.isDone,
                    onChanged: (val) => controller.toggleTaskStatus(task),
                    secondary: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => controller.deleteTask(task.id!),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}