import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingScreen extends StatefulWidget {
  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  // استخدام الإحداثيات بشكل صحيح
  static const LatLng _driverLocation = LatLng(15.3694, 44.1910); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تتبع المندوب"), 
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(target: _driverLocation, zoom: 14),
        markers: {
          const Marker(markerId: MarkerId('driver'), position: _driverLocation),
        },
      ),
    );
  }
}
