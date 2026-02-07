import 'package:flutter/material.dart';
import 'dart:async';
import '../main.dart'; // للعودة إلى التنقل الرئيسي

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
    
    // إعداد التوقيت والحركة (شغل جافا سكريبت ستايل الأنميشن)
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut, // حركة مرنة تجعل الشعار ينبض
    );

    // الانتقال للصفحة الرئيسية بعد 3 ثوانٍ
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavigation()),
      );
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
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // هنا نضع شعارك الجميل
              Image.network(
                'https://r2.erweima.ai/i/1770480557107.jpg', // رابط الشعار الذي أرفقته
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.orange), // مؤشر تحميل بلون الشعار
              SizedBox(height: 10),
              Text("جاري التحميل...", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
