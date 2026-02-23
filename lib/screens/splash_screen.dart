import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'login_screen.dart'; // سيوجه المستخدم للوجن بعد الثواني

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // شعار التطبيق (تخيل اللوجو هنا)
            Icon(Icons.flash_on, size: 80, color: Colors.amber),
            SizedBox(height: 20),
            Text(
              "فلكس يمن",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
            ),
            Text("الضمان والثقة في كل صفقة", style: TextStyle(color: Colors.amber)),
            SizedBox(height: 50),
            SpinKitThreeBounce(color: Colors.amber, size: 30.0),
          ],
        ),
      ),
    );
  }
}
