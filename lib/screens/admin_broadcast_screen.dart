import 'package:flutter/material.dart';

class AdminBroadcastScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إرسال إشعار جماعي")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: "عنوان التنبيه")),
            TextField(controller: _bodyController, decoration: InputDecoration(labelText: "نص الرسالة")),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // هنا يتم ربط الـ API لإرسال الإشعار لجميع المشتركين
                print("تم إرسال: ${_titleController.text}");
              },
              child: Text("إرسال للجميع فوراً 🔥"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
