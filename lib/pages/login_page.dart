import 'package:flutter/material.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainNavigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade600],
            begin: Alignment.topCenter
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/app_icon.png', width: 120, height: 120),
            SizedBox(height: 40),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "رقم الهاتف (77xxxxxxx)",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                if (_phoneController.text.isNotEmpty) _navigateToHome();
              },
              child: Text("تسجيل الدخول", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 15),
            // زر الدخول كضيف
            TextButton(
              onPressed: _navigateToHome,
              child: Text(
                "تصفح التطبيق كضيف",
                style: TextStyle(color: Colors.white70, decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "بدخولك كضيف يمكنك التصفح فقط، للشراء يرجى التسجيل",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
