import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cau5/views/dictionary_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DictionaryApp());
}

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Từ điển offline',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: DictionaryView(),
    );
  }
}