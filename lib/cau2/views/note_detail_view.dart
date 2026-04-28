import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../data/models/note_model.dart';

class NoteDetailView extends StatefulWidget {
  final NoteModel? note;
  NoteDetailView({this.note});

  @override
  State<NoteDetailView> createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  final NoteController controller = Get.find();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
      selectedCategoryId = widget.note!.categoryId;
    } else if (controller.categories.isNotEmpty) {
      selectedCategoryId = controller.categories.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.note == null ? "Thêm ghi chú" : "Sửa ghi chú")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => DropdownButtonFormField<int>(
              value: selectedCategoryId,
              decoration: const InputDecoration(labelText: "Danh mục"),
              items: controller.categories.map((cat) => DropdownMenuItem(value: cat.id, child: Text(cat.name))).toList(),
              onChanged: (val) => setState(() => selectedCategoryId = val),
            )),
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Tiêu đề")),
            TextField(controller: contentController, decoration: const InputDecoration(labelText: "Nội dung"), maxLines: 5),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty || selectedCategoryId == null) return;
                if (widget.note == null) {
                  controller.addNote(titleController.text, contentController.text, selectedCategoryId!);
                } else {
                  controller.updateNote(NoteModel(
                    id: widget.note!.id,
                    title: titleController.text,
                    content: contentController.text,
                    categoryId: selectedCategoryId!,
                  ));
                }
                Get.back();
              },
              child: const Text("Lưu"),
            )
          ],
        ),
      ),
    );
  }
}