import 'package:flutter/material.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => FlexYemenApp(),
      ));
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
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // شعار التطبيق الذي سيظهر بشكل انسيابي
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.amber.withOpacity(0.2), blurRadius: 40, spreadRadius: 10)
                  ],
                ),
                child: Image.asset('assets/images/icon.png', errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.flash_on, size: 100, color: Colors.amber);
                }),
              ),
              SizedBox(height: 20),
              Text("FLEX YEMEN", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 5, color: Colors.amber)),
              SizedBox(height: 10),
              Text("سوق اليمن الأول", style: TextStyle(color: Colors.white54, fontSize: 16)),
              SizedBox(height: 50),
              CircularProgressIndicator(color: Colors.amber, strokeWidth: 2),
            ],
          ),
        ),
      ),
    );
  }
}
