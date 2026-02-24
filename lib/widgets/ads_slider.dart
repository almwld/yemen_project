import 'package:flutter/material.dart';
import 'dart:async';

class AdsSlider extends StatefulWidget {
  @override
  _AdsSliderState createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  
  final List<Map<String, String>> ads = [
    {'title': 'عروض المستشفى الألماني الحديث', 'img': 'hosp_ad.jpg', 'color': '0xFFB71C1C'},
    {'title': 'خصومات الصيف في هايبر شملان', 'img': 'mall_ad.jpg', 'color': '0xFF1B5E20'},
    {'title': 'مخططات سكنية جديدة - حدة', 'img': 'real_ad.jpg', 'color': '0xFF01579B'},
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < ads.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_controller.hasClients) {
        _controller.animateToPage(_currentPage, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: PageView.builder(
        controller: _controller,
        itemCount: ads.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(int.parse(ads[index]['color']!)),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/400x200?text=${ads[index]['title']}'),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
            child: Center(
              child: Text(
                ads[index]['title']!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
