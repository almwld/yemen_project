import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String? selectedCategory;
  final List<String> categories = ["سيارات", "عقارات", "هواتف", "إلكترونيات"];
  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
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
            // منطقة رفع الصور المحسنة
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: gold.withOpacity(0.3), style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 50, color: gold),
                  const SizedBox(height: 10),
                  const Text("إضافة صور الإعلان", style: TextStyle(color: Colors.white54)),
                  const Text("(يمكنك اختيار حتى 10 صور)", style: TextStyle(color: Colors.white24, fontSize: 10)),
                ],
              ),
            ),
            const SizedBox(height: 25),
            
            // اختيار القسم (Dropdown)
            _buildDropdown(),
            const SizedBox(height: 15),
            
            _buildTextField("عنوان الإعلان (مثلاً: تويوتا كورولا 2022)"),
            const SizedBox(height: 15),
            
            // حقول متغيرة بناءً على القسم
            if (selectedCategory == "سيارات") ...[
              Row(
                children: [
                  Expanded(child: _buildTextField("سنة الصنع")),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField("ناقل الحركة")),
                ],
              ),
              const SizedBox(height: 15),
            ],

            _buildTextField("السعر (بالريال اليمني أو السعودي)"),
            const SizedBox(height: 15),
            
            _buildTextField("الوصف التفصيلي للإعلان", maxLines: 5),
            const SizedBox(height: 30),
            
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text("تم نشر إعلانك بنجاح!"), backgroundColor: gold),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: gold, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                child: const Text("نشر الإعلان الآن", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          hint: const Text("اختر قسم الإعلان", style: TextStyle(color: Colors.white30)),
          dropdownColor: const Color(0xFF1A1A1A),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: gold),
          items: categories.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedCategory = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white30, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }
}
