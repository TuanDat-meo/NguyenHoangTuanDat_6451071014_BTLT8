import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/expense_controller.dart';

class ExpenseDetailView extends StatefulWidget {
  @override
  State<ExpenseDetailView> createState() => _ExpenseDetailViewState();
}

class _ExpenseDetailViewState extends State<ExpenseDetailView> {
  final ExpenseController controller = Get.find();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  int? selectedId;

  @override
  void initState() {
    super.initState();
    if (controller.categories.isNotEmpty) selectedId = controller.categories.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thêm chi tiêu")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              value: selectedId,
              decoration: const InputDecoration(labelText: "Danh mục"),
              items: controller.categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
              onChanged: (v) => setState(() => selectedId = v),
            ),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Số tiền (VNĐ)"),
            ),
            TextFormField(
              controller: noteController,
              decoration: const InputDecoration(labelText: "Ghi chú/Nội dung"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                final amount = double.tryParse(amountController.text) ?? 0;
                if (amount > 0 && selectedId != null) {
                  controller.addExpense(amount, noteController.text, selectedId!);
                  Get.back();
                }
              },
              child: const Text("LƯU CHI TIÊU"),
            )
          ],
        ),
      ),
    );
  }
}