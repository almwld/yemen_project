import 'package:flutter/material.dart';

class MapStoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("المتاجر القريبة 📍", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // مساحة الخريطة التفاعلية
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              image: DecorationImage(
                image: NetworkImage('https://maps.googleapis.com/maps/api/staticmap?center=Sanaa,Yemen&zoom=14&size=600x300&key=YOUR_KEY'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(child: Icon(Icons.location_on, color: Colors.red, size: 50)),
          ),
          // قائمة المتاجر المكتشفة حالياً في صنعاء
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                _storeTile("بقالة وامانات ركن بينون", "شارع تعز - تقاطع بينون", "٢٩٠ م"),
                _storeTile("سوبر ماركت السعيدة", "22 May East", "١٫٣ كم"),
                _storeTile("سوق المقالح", "الحربي - صنعاء", "٢٫١ كم"),
                _storeTile("سيتي ماكس", "شارع الخمسين", "٣٫٣ كم"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _storeTile(String name, String address, String distance) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        leading: Icon(Icons.store, color: Colors.amber),
        title: Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(address, style: TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: Text(distance, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
