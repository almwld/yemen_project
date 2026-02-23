import 'package:flutter/material.dart';
import 'dart:async';
import '../main.dart'; // سنقوم بتعديل main.dart لاحقاً لتبدأ من هنا

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // الانتقال للشاشة الرئيسية بعد 3 ثوانٍ
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.amber, Colors.orangeAccent, Colors.black],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    "FLEX",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "فلكس يمن",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "سوقك في جيبك",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(color: Colors.amber, strokeWidth: 2),
          ],
        ),
      ),
    );
  }
}
