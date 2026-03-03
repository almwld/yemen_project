import 'package:flutter/material.dart';

class VirtualTour360 extends StatefulWidget {
  final String roomName;
  const VirtualTour360({required this.roomName});

  @override
  _VirtualTour360State createState() => _VirtualTour360State();
}

class _VirtualTour360State extends State<VirtualTour360> {
  double _currentRotation = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("جولة افتراضية: ${widget.roomName}", style: const TextStyle(color: Color(0xFFD4AF37))),
        leading: IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: Stack(
        children: [
          // محاكة عرض الصورة البانورامية (GestureDetector للتحريك)
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _currentRotation += details.delta.dx * 0.01;
              });
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://images.unsplash.com/photo-1582719508461-905c673771fd"), // صورة تجريبية واسعة
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.sync, color: Color(0xFFD4AF37), size: 100, opacity: 0.5),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.black54,
                      child: const Text("اسحب لليمين واليسار للمعاينة 360°", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // شريط اختيار الغرف السفلي
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white12)),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  _roomThumb("المجلس", Icons.chair_outlined),
                  _roomThumb("الجناح الرئيسي", Icons.bed_outlined),
                  _roomThumb("المطبخ", Icons.kitchen_outlined),
                  _roomThumb("الإطلالة", Icons.landscape_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roomThumb(String name, IconData icon) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: const Color(0xFFD4AF37), size: 24),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 10)),
      ],
    ),
  );
}
