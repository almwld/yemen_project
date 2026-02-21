import 'package:flutter/material.dart';
import '../main.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "title": "مرحباً بك في فلكس يمن",
      "desc": "المنصة الأولى في اليمن للمزادات المباشرة والوساطة المضمونة.",
      "icon": "🤝"
    },
    {
      "title": "نظام الوساطة المالي",
      "desc": "أموالك في أمان! نحن نضمن حق البائع والمشتري عبر محفظة فلكس.",
      "icon": "💰"
    },
    {
      "title": "مزادات حقيقية",
      "desc": "شارك في مزادات الجنابي والسيارات والعقارات بكل شفافية.",
      "icon": "🔨"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: onboardingData.length,
            itemBuilder: (context, index) => _buildPage(onboardingData[index]),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentPage == onboardingData.length - 1)
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FlexYemenApp())),
                    child: Text("ابدأ الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(200, 50)),
                  )
                else
                  Row(
                    children: List.generate(onboardingData.length, (index) => _buildDot(index)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(Map<String, String> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(data['icon']!, style: TextStyle(fontSize: 100)),
        SizedBox(height: 40),
        Text(data['title']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Text(data['desc']!, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    return Container(
      height: 10,
      width: _currentPage == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(color: _currentPage == index ? Colors.amber : Colors.grey, borderRadius: BorderRadius.circular(5)),
    );
  }
}
