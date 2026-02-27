import 'package:flutter/material.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  String _selectedAddress = "جاري تحديد الموقع في صنعاء...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تحديد موقع التوصيل"), backgroundColor: Colors.black),
      body: Stack(
        children: [
          // خلفية محاكية للخريطة
          Container(
            color: Colors.grey[900],
            child: const Center(
              child: Icon(Icons.location_on, size: 80, color: Color(0xFFD4AF37)),
            ),
          ),
          
          // صندوق تفاصيل العنوان
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("عنوان التوصيل المختار:", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text(_selectedAddress, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("تم حفظ العنوان بنجاح!")),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("تأكيد هذا الموقع", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
