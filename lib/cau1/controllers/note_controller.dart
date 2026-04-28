import 'package:get/get.dart';
import '../data/models/note_model.dart';
import '../data/repository/note_repository.dart';

class NoteController extends GetxController {
  final NoteRepository _repository = NoteRepository();
  var notes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

void fetchNotes() async {
  var data = await _repository.getAllNotes();
  print("Dữ liệu lấy được: ${data.length} ghi chú"); 
  notes.assignAll(data);
}

void addNote(String title, String content) async {
  if (title.isEmpty) return; // Tránh lưu rỗng
  await _repository.insertNote(NoteModel(title: title, content: content));
  print("Đã thêm ghi chú mới!");
  fetchNotes(); // Gọi lại để cập nhật danh sách
}

  void updateNote(int id, String title, String content) async {
    await _repository.updateNote(NoteModel(id: id, title: title, content: content));
    fetchNotes();
  }

  void deleteNote(int id) async {
    await _repository.deleteNote(id);
    fetchNotes();
  }
}