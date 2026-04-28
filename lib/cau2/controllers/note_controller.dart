import 'package:get/get.dart';
import '../data/models/note_model.dart';
import '../data/models/category_model.dart';
import '../data/repository/note_repository.dart';

class NoteController extends GetxController {
  final NoteRepository _repository = NoteRepository();
  
  var notes = <NoteModel>[].obs;
  var categories = <CategoryModel>[].obs;
  var selectedFilterId = Rxn<int>(); 

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  void refreshData() async {
    await fetchCategories();
    await fetchNotes();
  }

  Future<void> fetchCategories() async {
    categories.assignAll(await _repository.getAllCategories());
  }

  Future<void> fetchNotes() async {
    notes.assignAll(await _repository.getAllNotes(categoryId: selectedFilterId.value));
  }

  void filterByCategory(int? id) {
    selectedFilterId.value = id;
    fetchNotes();
  }

  void addCategory(String name) async {
    await _repository.insertCategory(CategoryModel(name: name));
    fetchCategories();
  }

  void addNote(String title, String content, int categoryId) async {
    await _repository.insertNote(NoteModel(title: title, content: content, categoryId: categoryId));
    fetchNotes();
  }

  void updateNote(NoteModel note) async {
    await _repository.updateNote(note);
    fetchNotes();
  }

  void deleteNote(int id) async {
    await _repository.deleteNote(id);
    fetchNotes();
  }
}