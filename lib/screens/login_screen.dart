import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flash_on, size: 100, color: Colors.amber),
          Text("فلكس يمن", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          SizedBox(height: 50),
          // زر الدخول الرسمي
          ElevatedButton(
            onPressed: () { /* كود تسجيل الدخول */ },
            child: Text("تسجيل الدخول"),
            style: ElevatedButton.styleFrom(minimumSize: Size(300, 50), backgroundColor: Colors.amber),
          ),
          SizedBox(height: 15),
          // زر دخول الضيف الجديد
          OutlinedButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(isGuest: true)));
            },
            child: Text("التصفح كضيف", style: TextStyle(color: Colors.amber)),
            style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.amber), minimumSize: Size(300, 50)),
          ),
        ],
      ),
    );
  }
}
