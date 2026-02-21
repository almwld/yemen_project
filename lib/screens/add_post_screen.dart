import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("إضافة إعلان جديد"), centerTitle: true, elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // منطقة رفع الصور
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.amber.withOpacity(0.5), strokeAlign: 0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, color: Colors.amber, size: 40),
                  SizedBox(height: 10),
                  Text("اضغط لإضافة صور الإعلان", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 25),
            
            _buildField("عنوان الإعلان", "مثال: تويوتا كورولا 2020 نظيف"),
            _buildField("السعر (\$)", "أدخل السعر", isNumber: true),
            
            Text("القسم", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(filled: true, fillColor: Color(0xFF1E1E1E), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              items: [
                DropdownMenuItem(child: Text("سيارات"), value: "1"),
                DropdownMenuItem(child: Text("عقارات"), value: "2"),
                DropdownMenuItem(child: Text("جوالات"), value: "3"),
              ],
              onChanged: (val) {},
              hint: Text("اختر القسم"),
            ),
            
            SizedBox(height: 20),
            _buildField("وصف المنتج", "اكتب تفاصيل المنتج وحالته...", maxLines: 4),
            
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم نشر إعلانك بنجاح في فلكس يمن")));
              },
              child: Text("نشر الإعلان الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, {bool isNumber = false, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        TextField(
          maxLines: maxLines,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Color(0xFF1E1E1E),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
