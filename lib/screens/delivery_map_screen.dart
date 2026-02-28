import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryMapScreen extends StatefulWidget {
  const DeliveryMapScreen({super.key});

  @override
  State<DeliveryMapScreen> createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen> {
  late GoogleMapController mapController;
  final Color gold = const Color(0xFFD4AF37);

  // موقع افتراضي (صنعاء - كمثال)
  static const LatLng _center = LatLng(15.3694, 44.1910);
  static const LatLng _driverPos = LatLng(15.3720, 44.1950);

  // ستايل الخريطة الليلي (JSON) لجعلها متناسقة مع ثيم فلكس
  final String _darkMapStyle = '''[
    {"elementType": "geometry", "stylers": [{"color": "#212121"}]},
    {"elementType": "labels.text.fill", "stylers": [{"color": "#757575"}]},
    {"featureType": "road", "elementType": "geometry", "stylers": [{"color": "#303030"}]},
    {"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#000000"}]}
  ]''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تتبع طلبك - فلكس يمن", style: TextStyle(color: Color(0xFFD4AF37))),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: gold),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
              mapController.setMapStyle(_darkMapStyle);
            },
            initialCameraPosition: const CameraPosition(target: _center, zoom: 15),
            markers: {
              Marker(
                markerId: const MarkerId('dest'),
                position: _center,
                infoWindow: const InfoWindow(title: 'موقعك'),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
              ),
              Marker(
                markerId: const MarkerId('driver'),
                position: _driverPos,
                infoWindow: const InfoWindow(title: 'السائق يقترب...'),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
              ),
            },
          ),
          
          // واجهة معلومات السائق السفلية
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: gold.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  CircleAvatar(radius: 25, backgroundColor: gold, child: const Icon(Icons.person, color: Colors.black)),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("أحمد الكبسي", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text("توصيل سريع - دراجة نارية", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.phone, color: gold),
                    onPressed: () {}, // اتصال بالسائق
                  ),
                  IconButton(
                    icon: Icon(Icons.chat_bubble, color: gold),
                    onPressed: () {}, // شات مع السائق
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
