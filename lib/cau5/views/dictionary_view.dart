import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dictionary_controller.dart';

class DictionaryView extends StatelessWidget {
  final DictionaryController controller = Get.put(DictionaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Từ điển Offline", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Nguyễn Hoàng Tuấn Đạt - 6451071014", style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) => controller.search(value),
              decoration: InputDecoration(
                hintText: "Nhập từ cần tra cứu...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          // Danh sách kết quả
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.foundWords.isEmpty) {
                return const Center(child: Text("Không tìm thấy kết quả."));
              }
              return ListView.builder(
                itemCount: controller.foundWords.length,
                itemBuilder: (context, index) {
                  final item = controller.foundWords[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: ListTile(
                      title: Text(item.word, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                      subtitle: Text(item.meaning),
                      leading: const Icon(Icons.translate),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}