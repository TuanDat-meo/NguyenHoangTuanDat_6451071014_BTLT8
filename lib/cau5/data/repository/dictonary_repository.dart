import '../models/word_model.dart';
import '../services/database_service.dart';
import 'package:sqflite/sqflite.dart';
class DictionaryRepository {
  final dbService = DatabaseService();

  Future<int> insertWord(WordModel word) async {
    final db = await dbService.database;
    return await db.insert('dictionary', word.toMap());
  }

  // Kiểm tra xem database đã có dữ liệu chưa
  Future<bool> isDatabaseEmpty() async {
    final db = await dbService.database;
    var count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM dictionary'));
    return count == 0;
  }

  // Tìm kiếm từ vựng (Sử dụng LIKE để tìm kiếm gần đúng)
  Future<List<WordModel>> searchWords(String query) async {
    final db = await dbService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'dictionary',
      where: 'word LIKE ?',
      whereArgs: ['%$query%'],
    );
    return List.generate(maps.length, (i) => WordModel.fromMap(maps[i]));
  }
}