import 'package:sqflite/sqflite.dart';
import '../models/note_model.dart';
import '../services/database_service.dart';

class NoteRepository {
  final dbService = DatabaseService();

  Future<int> insertNote(NoteModel note) async {
    final db = await dbService.database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<NoteModel>> getAllNotes() async {
    final db = await dbService.database;
    final List<Map<String, dynamic>> maps = await db.query('notes', orderBy: 'id DESC');
    return List.generate(maps.length, (i) => NoteModel.fromMap(maps[i]));
  }

  Future<int> updateNote(NoteModel note) async {
    final db = await dbService.database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await dbService.database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}