import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../data/models/word_model.dart';
import 'package:btlt8/cau5/data/repository/dictonary_repository.dart';

class DictionaryController extends GetxController {
  final DictionaryRepository _repository = DictionaryRepository();
  var foundWords = <WordModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  // Logic nạp dữ liệu từ JSON vào SQLite khi chạy lần đầu
  Future<void> initData() async {
    isLoading.value = true;
    bool isEmpty = await _repository.isDatabaseEmpty();
    
    if (isEmpty) {
      try {
        final String response = await rootBundle.loadString('assets/data/dictionary.json');
        final List<dynamic> data = jsonDecode(response);
        
        for (var item in data) {
          await _repository.insertWord(WordModel(
            word: item['word'], 
            meaning: item['meaning']
          ));
        }
      } catch (e) {
        Get.snackbar("Lỗi", "Không thể load dữ liệu JSON: $e");
      }
    }
    
    // Load danh sách ban đầu (rỗng hoặc toàn bộ tùy ý)
    search(""); 
    isLoading.value = false;
  }

  void search(String query) async {
    foundWords.assignAll(await _repository.searchWords(query));
  }
}