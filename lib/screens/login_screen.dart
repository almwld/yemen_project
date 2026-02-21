import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "سوق اليمن الشامل",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 60),
              // زر تسجيل الدخول
              ElevatedButton(
                onPressed: () {
                  // هنا ننتقل للرئيسية عند الضغط
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 20),
              // زر الدخول كضيف
              TextButton(
                onPressed: () {
                   Navigator.pushReplacementNamed(context, '/home');
                },
                child: Text(
                  "الدخول كضيف",
                  style: TextStyle(color: Colors.amber, fontSize: 16, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
