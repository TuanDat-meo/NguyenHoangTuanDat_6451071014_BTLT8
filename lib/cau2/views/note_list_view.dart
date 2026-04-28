import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import 'note_detail_view.dart';
import 'category_manage_view.dart';

class NoteListView extends StatelessWidget {
  final NoteController controller = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ghi chú của tôi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("Nguyễn Hoàng Tuấn Đạt - 6451071014", style: TextStyle(fontSize: 13)),
            const SizedBox(height: 5),
            // Thanh lọc danh mục
            Obx(() => DropdownButton<int?>(
              isExpanded: true,
              value: controller.selectedFilterId.value,
              hint: const Text("Tất cả danh mục"),
              items: [
                const DropdownMenuItem(value: null, child: Text("Tất cả danh mục")),
                ...controller.categories.map((cat) => DropdownMenuItem(value: cat.id, child: Text(cat.name))),
              ],
              onChanged: (val) => controller.filterByCategory(val),
            )),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () => Get.to(() => CategoryManageView()),
          )
        ],
      ),
      body: Obx(() {
        if (controller.notes.isEmpty) return const Center(child: Text("Không có ghi chú nào."));
        return ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            final note = controller.notes[index];
            return ListTile(
              title: Text(note.title),
              subtitle: Text("${note.categoryName} • ${note.content}", maxLines: 1),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteNote(note.id!),
              ),
              onTap: () => Get.to(() => NoteDetailView(note: note)),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.categories.isEmpty) {
            Get.snackbar("Thông báo", "Vui lòng tạo danh mục trước!");
          } else {
            Get.to(() => NoteDetailView());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}