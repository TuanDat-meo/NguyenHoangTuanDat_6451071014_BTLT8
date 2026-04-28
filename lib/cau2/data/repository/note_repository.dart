import '../models/note_model.dart';
import '../models/category_model.dart';
import '../services/database_service.dart';

class NoteRepository {
  final dbService = DatabaseService();


  Future<List<NoteModel>> getAllNotes({int? categoryId}) async {
    final db = await dbService.database;
    String query = '''
      SELECT notes.*, categories.name as category_name 
      FROM notes 
      JOIN categories ON notes.categoryId = categories.id
    ''';
    if (categoryId != null) query += ' WHERE notes.categoryId = $categoryId';
    
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return List.generate(maps.length, (i) => NoteModel.fromMap(maps[i]));
  }

  Future<int> insertNote(NoteModel note) async {
    final db = await dbService.database;
    return await db.insert('notes', note.toMap());
  }

  Future<int> updateNote(NoteModel note) async {
    final db = await dbService.database;
    return await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    final db = await dbService.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // --- Danh mục (Categories) ---
  Future<List<CategoryModel>> getAllCategories() async {
    final db = await dbService.database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) => CategoryModel.fromMap(maps[i]));
  }

  Future<int> insertCategory(CategoryModel category) async {
    final db = await dbService.database;
    return await db.insert('categories', category.toMap());
  }
}