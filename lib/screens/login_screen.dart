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
                "Flex Yemen Market",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "فلكس يمن ماركت",
                style: TextStyle(color: Colors.white70, fontSize: 18, fontFamily: 'Cairo'),
              ),
              SizedBox(height: 80),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cairo'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                child: Text(
                  "الدخول كضيف",
                  style: TextStyle(color: Colors.amber, fontSize: 16, fontFamily: 'Cairo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
