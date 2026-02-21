import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("أضف إعلان جديد"), centerTitle: true),
      body: Center(
        child: Text("صفحة إضافة الإعلانات قيد التجهيز لـ Flex Yemen", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
