import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

class DeliveryTrackingScreen extends StatefulWidget {
  final String orderId;
  const DeliveryTrackingScreen({super.key, required this.orderId});

  @override
  State<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  final Color gold = const Color(0xFFD4AF37);
  GoogleMapController? _controller;
  LatLng _driverLocation = const LatLng(15.3694, 44.1910); // موقع افتراضي (صنعاء)
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _startTracking();
  }

  // ربط حي مع سوبابيس لجلب موقع السائق فور تحديثه
  void _startTracking() {
    _subscription = Supabase.instance.client
        .from('delivery_locations')
        .stream(primaryKey: ['id'])
        .eq('order_id', widget.orderId)
        .listen((data) {
          if (data.isNotEmpty) {
            setState(() {
              _driverLocation = LatLng(data.first['lat'], data.first['lng']);
              _controller?.animateCamera(CameraUpdate.newLatLng(_driverLocation));
            });
          }
        });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("تتبع طلبك مباشر", style: TextStyle(color: Colors.white)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _driverLocation, zoom: 15),
            onMapCreated: (controller) => _controller = controller,
            markers: {
              Marker(
                markerId: const MarkerId('driver'),
                position: _driverLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                infoWindow: const InfoWindow(title: "المندوب يقترب منك"),
              ),
            },
          ),
          // واجهة معلومات السائق السفلية
          Positioned(
            bottom: 20, left: 15, right: 15,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: gold, width: 2),
              ),
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: gold, child: const Icon(Icons.delivery_dining, color: Colors.black)),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("أحمد الكبسي", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text("دراجة نارية - لوحة 1234", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.phone, color: Colors.green), onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
