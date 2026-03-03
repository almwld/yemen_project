import 'package:flutter/material.dart';

class SecureMapView extends StatefulWidget {
  final bool isDepositPaid; // هل تم دفع العربون؟
  final String propertyLocation;

  const SecureMapView({required this.isDepositPaid, required this.propertyLocation});

  @override
  _SecureMapViewState createState() => _SecureMapViewState();
}

class _SecureMapViewState extends State<SecureMapView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black26,
      ),
      child: Stack(
        children: [
          // إذا لم يتم الدفع، نعرض خريطة مشوشة أو رسالة قفل
          if (!widget.isDepositPaid)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, color: Color(0xFFD4AF37), size: 50),
                  const SizedBox(height: 10),
                  const Text("موقع العقار الدقيق مخفي", style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text("يظهر الموقع تلقائياً بعد دفع العربون لضمان الجدية", 
                    style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {}, // توجيه للمحفظة لدفع العربون
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                    child: const Text("دفع العربون الآن", style: TextStyle(color: Colors.black)),
                  )
                ],
              ),
            )
          else
            // إذا تم الدفع، تظهر الخريطة الحقيقية (Google Maps)
            const Center(
              child: Text("🗺️ تم فتح الموقع الدقيق! جاري تحميل الخريطة..."),
            ),
        ],
      ),
    );
  }
}
