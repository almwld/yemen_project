import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as slider;

class ScrollingBanners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return slider.CarouselSlider(
      options: slider.CarouselOptions(height: 150.0, autoPlay: true, enlargeCenterPage: true),
      items: [1,2,3].map((i) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(15)),
          child: Center(child: Text("إعلان مميز $i", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
        );
      }).toList(),
    );
  }
}
