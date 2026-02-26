import 'package:flutter/material.dart';

class MapViewScreen extends StatelessWidget {
  final String locationName;
  const MapViewScreen({super.key, required this.locationName});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("موقع $locationName", style: TextStyle(color: gold)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: gold),
      ),
      body: Stack(
        children: [
          // خلفية تمثل الخريطة (بانتظار مفتاح API الحقيقي)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[900],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, size: 100, color: gold.withOpacity(0.5)),
                  const SizedBox(height: 20),
                  const Text("جاري تحميل الخريطة...", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
          // واجهة تفاعلية فوق الخريطة
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: gold, width: 0.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: gold, size: 40),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(locationName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        const Text("صنعاء - شارع الخمسين", style: TextStyle(color: Colors.white54, fontSize: 12)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: gold),
                    child: const Text("توجيه", style: TextStyle(color: Colors.black)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
