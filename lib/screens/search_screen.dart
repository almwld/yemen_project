import 'package:flutter/material.dart';

class AdvancedSearchScreen extends StatefulWidget {
  @override
  _AdvancedSearchScreenState createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  String selectedCity = 'الكل';
  RangeValues priceRange = RangeValues(100, 10000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("البحث المتطور"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("نطاق السعر", style: TextStyle(color: Colors.amber)),
            RangeSlider(
              values: priceRange,
              min: 0,
              max: 20000,
              onChanged: (values) => setState(() => priceRange = values),
            ),
            Text("من: ${priceRange.start.round()}\$", style: TextStyle(color: Colors.grey)),
            Text("إلى: ${priceRange.end.round()}\$", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
