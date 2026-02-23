import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String driverId;
  OrderTrackingScreen({required this.driverId});

  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final supabase = Supabase.instance.client;
  LatLng _driverLocation = LatLng(15.3694, 44.1910); // إحداثيات افتراضية لصنعاء

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تتبع الطلب - فلكس يمن"), backgroundColor: Colors.amber),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase.from('profiles').stream(primaryKey: ['id']).eq('id', widget.driverId),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final data = snapshot.data!.first;
            _driverLocation = LatLng(data['last_lat'] ?? 15.3694, data['last_long'] ?? 44.1910);
          }

          return GoogleMap(
            initialCameraPosition: CameraPosition(target: _driverLocation, zoom: 15),
            markers: {
              Marker(
                markerId: MarkerId('driver'),
                position: _driverLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAmber),
                infoWindow: InfoWindow(title: "المندوب قادم إليك"),
              ),
            },
          );
        },
      ),
    );
  }
}
