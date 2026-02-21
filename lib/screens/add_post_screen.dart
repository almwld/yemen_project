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
            // منطقة الصور (كما هي)
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.amber.withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo_outlined, color: Colors.amber, size: 40),
                  SizedBox(height: 10),
                  Text("إضافة صور للمنتج", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 25),
            
            _buildField("عنوان الإعلان", "ماذا تبيع؟"),
            _buildField("السعر (\$)", "0.00", isNumber: true),
            
            // ميزة تحديد الموقع الجديدة
            Text("موقع السلعة", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                // محاكاة فتح خريطة أو قائمة مدن
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.amber),
                    SizedBox(width: 10),
                    Text("حدد المدينة (صنعاء، عدن، تعز...)", style: TextStyle(color: Colors.white70)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 25),
            _buildField("وصف الإعلان", "اكتب مواصفات السلعة بدقة...", maxLines: 4),
            
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("جاري معالجة الإعلان ونشره على Flex Yemen..."),
                    backgroundColor: Colors.amber,
                  )
                );
              },
              child: Text("نشر الإعلان الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            SizedBox(height: 20),
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
