import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("إضافة إعلان جديد", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: gold),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // زر اختيار الصور
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: gold, style: BorderStyle.none),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, color: gold, size: 50),
                  const SizedBox(height: 10),
                  const Text("إضافة صور الإعلان", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildInput("عنوان الإعلان (مثلاً: تويوتا كورولا 2020)"),
            _buildInput("السعر (بالريال اليمني أو السعودي)"),
            _buildInput("الوصف التفصيلي"),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text("تم إرسال إعلانك للمراجعة بنجاح"), backgroundColor: gold),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                child: const Text("نشر الإعلان الآن", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white30),
          filled: true,
          fillColor: const Color(0xFF1A1A1A),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
