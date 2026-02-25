import 'package:flutter/material.dart';
import 'dart:async';

class AdsSlider extends StatefulWidget {
  @override
  _AdsSliderState createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final Color goldColor = Color(0xFFD4AF37);

  final List<Map<String, String>> ads = [
    {
      'title': 'عروض المستشفى الألماني الحديث', 
      'img': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?q=80&w=500', 
    },
    {
      'title': 'خصومات الصيف في هايبر شملان', 
      'img': 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?q=80&w=500',
    },
    {
      'title': 'مخططات سكنية جديدة - حدة', 
      'img': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?q=80&w=500',
    },
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
        _controller.animateToPage(
          _currentPage, 
          duration: Duration(milliseconds: 800), 
          curve: Curves.fastOutSlowIn
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          child: PageView.builder(
            controller: _controller,
            itemCount: ads.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: goldColor.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(color: goldColor.withOpacity(0.1), blurRadius: 8, spreadRadius: 1)
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(ads[index]['img']!, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            ads[index]['title']!,
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(color: Colors.black, blurRadius: 5)]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(ads.length, (index) => AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 4),
            height: 6,
            width: _currentPage == index ? 20 : 6,
            decoration: BoxDecoration(
              color: _currentPage == index ? goldColor : Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(3),
            ),
          )),
        ),
      ],
    );
  }
}
