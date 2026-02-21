import 'package:flutter/material.dart';
import 'dart:async';

class ScrollingBanners extends StatefulWidget {
  @override
  _ScrollingBannersState createState() => _ScrollingBannersState();
}

class _ScrollingBannersState extends State<ScrollingBanners> {
  final PageController _controller = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> ads = [
    {"title": "مزاد تويوتا الكبري", "color": Colors.blue[800]},
    {"title": "فلل فاخرة في صنعاء", "color": Colors.green[800]},
    {"title": "تصفية إلكترونيات", "color": Colors.red[800]},
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPage < ads.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_controller.hasClients) {
        _controller.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: PageView.builder(
        controller: _controller,
        itemCount: ads.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: ads[index]['color'],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 4))
                  ],
                ),
                child: Center(
                  child: Text(
                    ads[index]['title'],
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
