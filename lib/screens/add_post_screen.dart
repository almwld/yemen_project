import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool isAuction = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("نشر إعلان / مزاد")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildImagePicker(),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text("عرض المنتج في المزاد"),
              subtitle: Text("سيتمكن المستخدمون من المزايدة على السعر"),
              value: isAuction,
              activeColor: Colors.amber,
              onChanged: (val) => setState(() => isAuction = val),
            ),
            TextField(decoration: InputDecoration(labelText: "عنوان الإعلان")),
            TextField(decoration: InputDecoration(labelText: isAuction ? "سعر البداية (\$)" : "السعر الثابت (\$)")),
            if (isAuction) TextField(decoration: InputDecoration(labelText: "مدة المزاد (بالأيام)")),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("نشر الآن", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Container(
      height: 150, width: double.infinity,
      decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.amber)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_a_photo, color: Colors.amber, size: 40),
          Text("ارفع صور من الاستديو", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
