import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../data/models/note_model.dart';

class NoteDetailView extends StatelessWidget {
  final NoteModel? note;
  final NoteController controller = Get.find<NoteController>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  NoteDetailView({this.note}) {
    if (note != null) {
      titleController.text = note!.title;
      contentController.text = note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note == null ? "Thêm ghi chú" : "Sửa ghi chú")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Tiêu đề")),
            TextField(controller: contentController, decoration: InputDecoration(labelText: "Nội dung"), maxLines: 5),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (note == null) {
                  controller.addNote(titleController.text, contentController.text);
                } else {
                  controller.updateNote(note!.id!, titleController.text, contentController.text);
                }
                Get.back();
              },
              child: Text("Lưu ghi chú"),
            )
          ],
        ),
      ),
    );
  }
}