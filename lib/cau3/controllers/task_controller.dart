import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../data/models/task_model.dart';
import '../data/repository/task_repository.dart';

class TaskController extends GetxController {
  final TaskRepository _repository = TaskRepository();
  var tasks = <TaskModel>[].obs;

@override
void onInit() { 
  super.onInit(); // Gọi super.onInit() của GetxController
  fetchTasks();
}

  void fetchTasks() async {
    tasks.assignAll(await _repository.getAllTasks());
  }

  void addTask(String title) async {
    if (title.isEmpty) return;
    await _repository.insertTask(TaskModel(title: title));
    fetchTasks();
  }

  void toggleTaskStatus(TaskModel task) async {
    task.isDone = !task.isDone;
    await _repository.updateTask(task);
    fetchTasks();
  }

  void deleteTask(int id) async {
    await _repository.deleteTask(id);
    fetchTasks();
  }

  // --- CHỨC NĂNG EXPORT JSON ---
  Future<void> exportToJson() async {
    try {
      // 1. Chuyển danh sách sang String JSON
      List<Map<String, dynamic>> jsonData = tasks.map((t) => t.toJson()).toList();
      String jsonString = jsonEncode(jsonData);

      // 2. Lấy đường dẫn lưu file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/tasks_backup.json');

      // 3. Ghi file
      await file.writeAsString(jsonString);
      
      Get.snackbar("Thành công", "Đã lưu backup tại: ${file.path}");
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể export: $e");
    }
  }

  // --- CHỨC NĂNG IMPORT JSON ---
  Future<void> importFromJson() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/tasks_backup.json');

      if (!await file.exists()) {
        Get.snackbar("Lỗi", "Không tìm thấy file backup!");
        return;
      }

      // 1. Đọc file
      String jsonString = await file.readAsString();
      List<dynamic> jsonData = jsonDecode(jsonString);

      // 2. Xóa data cũ và nạp data mới vào DB
      await _repository.clearAllTasks();
      for (var item in jsonData) {
        await _repository.insertTask(TaskModel.fromMap(item));
      }

      fetchTasks();
      Get.snackbar("Thành công", "Đã phục hồi dữ liệu từ file JSON!");
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể import: $e");
    }
  }
}