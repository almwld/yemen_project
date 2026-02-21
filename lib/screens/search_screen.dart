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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // حقل البحث النصي
            TextField(
              decoration: InputDecoration(
                hintText: "عن ماذا تبحث؟",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color(0xFF1E1E1E),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 25),
            
            Text("تصفية حسب المدينة", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedCity,
              decoration: InputDecoration(filled: true, fillColor: Color(0xFF1E1E1E), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              items: ['الكل', 'صنعاء', 'عدن', 'تعز', 'المكلا', 'إب'].map((city) => DropdownMenuItem(child: Text(city), value: city)).toList(),
              onChanged: (val) => setState(() => selectedCity = val!),
            ),
            
            SizedBox(height: 25),
            Text("نطاق السعر", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
            RangeSlider(
              values: priceRange,
              min: 0,
              max: 20000,
              divisions: 20,
              labels: RangeLabels('${priceRange.start.round()}', '${priceRange.end.round()}'),
              onChanged: (values) => setState(() => priceRange = values),
              activeColor: Colors.amber,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("من: ${priceRange.start.round()}$", style: TextStyle(color: Colors.grey)),
                Text("إلى: ${priceRange.end.round()}$", style: TextStyle(color: Colors.grey)),
              ],
            ),
            
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // هنا سيتم تنفيذ الفلترة لاحقاً
              },
              child: Text("إظهار النتائج", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
