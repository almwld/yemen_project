import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class AddressPickerScreen extends StatefulWidget {
  const AddressPickerScreen({super.key});

  @override
  State<AddressPickerScreen> createState() => _AddressPickerScreenState();
}

class _AddressPickerScreenState extends State<AddressPickerScreen> {
  late GoogleMapController mapController;
  // إحداثيات افتراضية لصنعاء (ميدان السبعين)
  final LatLng _center = const LatLng(15.3255, 44.2057);
  LatLng _lastMapPosition = const LatLng(15.3255, 44.2057);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("حدد موقع التوصيل"),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 15.0),
            onCameraMove: _onCameraMove,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          // مؤشر الدبوس في منتصف الشاشة
          const Center(
            child: Icon(Icons.location_on, size: 50, color: Color(0xFFD4AF37)),
          ),
          // زر التأكيد
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                // هنا يتم حفظ الإحداثيات والعودة
                Navigator.pop(context, _lastMapPosition);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("تأكيد هذا الموقع", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
