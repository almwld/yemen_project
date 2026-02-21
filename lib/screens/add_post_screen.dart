import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String _selectedCategory = "سيارات";
  final List<String> _categories = ["سيارات", "عقارات", "مزادات", "مقتنيات تراثية", "إلكترونيات"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(title: Text("أضف إعلانك الجديد")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildImagePicker(),
            SizedBox(height: 20),
            _buildTextField("عنوان الإعلان", "مثال: تويوتا كورولا 2020"),
            SizedBox(height: 15),
            _buildCategoryDropdown(),
            SizedBox(height: 15),
            _buildTextField("السعر (ريال يمني / دولار)", "أدخل السعر المطلوب", isNumber: true),
            SizedBox(height: 15),
            _buildTextField("وصف التفاصيل", "اكتب حالة السلعة بكل صراحة...", isLong: true),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _showSuccessDialog(context),
              child: Text("نشر الإعلان الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 55)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.amber.withOpacity(0.3))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.add_a_photo, color: Colors.amber, size: 40), Text("إضافة صور")],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {bool isNumber = false, bool isLong = false}) {
    return TextField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: isLong ? 4 : 1,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Color(0xFF1E1E1E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField(
      value: _selectedCategory,
      items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
      onChanged: (val) => setState(() => _selectedCategory = val.toString()),
      decoration: InputDecoration(filled: true, fillColor: Color(0xFF1E1E1E), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("تم بنجاح"),
        content: Text("إعلانك الآن قيد المراجعة وسيظهر للجميع فوراً."),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("حسناً"))],
      ),
    );
  }
}
