import '../models/task_model.dart';
import '../services/database_service.dart';

class TaskRepository {
  final dbService = DatabaseService();

  Future<List<TaskModel>> getAllTasks() async {
    final db = await dbService.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks', orderBy: 'id DESC');
    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  Future<int> insertTask(TaskModel task) async {
    final db = await dbService.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<int> updateTask(TaskModel task) async {
    final db = await dbService.database;
    return await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await dbService.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  // Hàm xóa sạch để Import mới
  Future<void> clearAllTasks() async {
    final db = await dbService.database;
    await db.delete('tasks');
  }
}