import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String? selectedCategory;
  final List<String> categories = ["عقارات", "سيارات", "ستارلينك", "جوالات", "إلكترونيات", "خدمات"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة إعلان جديد", style: TextStyle(color: Color(0xFFD4AF37))),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text("اختر القسم المناسب", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              hint: const Text("اختر القسم"),
              value: selectedCategory,
              items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => selectedCategory = val),
            ),
            const SizedBox(height: 25),
            const Text("صور الإعلان (حد أقصى 5)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildAddImageBox(),
                const SizedBox(width: 10),
                _buildAddImageBox(),
              ],
            ),
            const SizedBox(height: 25),
            const Text("عنوان الإعلان", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            _buildTextField("مثال: فيلا للبيع في حدة"),
            const SizedBox(height: 20),
            const Text("وصف الإعلان", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            _buildTextField("اكتب كافة التفاصيل هنا...", maxLines: 4),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildTextField("السعر (RY / \$)")),
                const SizedBox(width: 15),
                const Text("السعر", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("تم إرسال الإعلان للمراجعة بنجاح ✅", textAlign: TextAlign.center))
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("نشر الإعلان الآن", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 100), // مساحة إضافية للبار السفلي
          ],
        ),
      ),
    );
  }

  Widget _buildAddImageBox() => Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white24)),
    child: const Icon(Icons.add_a_photo, color: Color(0xFFD4AF37)),
  );

  Widget _buildTextField(String hint, {int maxLines = 1}) => Container(
    margin: const EdgeInsets.only(top: 10),
    child: TextField(
      maxLines: maxLines,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    ),
  );
}
