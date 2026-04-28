import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import 'note_detail_view.dart';

class NoteListView extends StatelessWidget {
  final NoteController controller = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ghi chú của tôi  \n Nguyễn Hoàng Tuấn Đạt-6451071014")),
      body: Obx(() => ListView.builder(
            itemCount: controller.notes.length,
            itemBuilder: (context, index) {
              final note = controller.notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content, maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.deleteNote(note.id!),
                ),
                onTap: () => Get.to(() => NoteDetailView(note: note)),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => NoteDetailView()),
        child: Icon(Icons.add),
      ),
    );
  }
}