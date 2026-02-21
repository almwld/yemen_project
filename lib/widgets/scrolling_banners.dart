import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ScrollingBanners extends StatelessWidget {
  final List<Map<String, String>> ads = [
    {"title": "مزاد تويوتا الكبري", "image": "🚗", "color": "0xFF1E88E5"},
    {"title": "فلل فاخرة في صنعاء", "image": "🏡", "color": "0xFF43A047"},
    {"title": "تصفية إلكترونيات", "image": "💻", "color": "0xFFE53935"},
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16/9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.85,
      ),
      items: ads.map((ad) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Color(int.parse(ad['color']!)),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Center(child: Text(ad['image']!, style: TextStyle(fontSize: 50))),
                  Positioned(
                    bottom: 10,
                    left: 20,
                    child: Text(
                      ad['title']!,
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
