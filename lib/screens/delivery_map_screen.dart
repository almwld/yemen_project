import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeliveryMapScreen extends StatefulWidget {
  final int orderId;
  const DeliveryMapScreen({super.key, required this.orderId});

  @override
  State<DeliveryMapScreen> createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen> {
  late GoogleMapController mapController;
  LatLng _deliveryPos = const LatLng(15.3694, 44.1910); // موقع افتراضي في صنعاء

  @override
  void initState() {
    super.initState();
    _listenToDeliveryLocation();
  }

  void _listenToDeliveryLocation() {
    Supabase.instance.client
        .from('delivery_locations')
        .stream(primaryKey: ['id'])
        .eq('order_id', widget.orderId)
        .listen((data) {
          if (data.isNotEmpty) {
            setState(() {
              _deliveryPos = LatLng(data.first['latitude'], data.first['longitude']);
            });
            mapController.animateCamera(CameraUpdate.newLatLng(_deliveryPos));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تتبع المندوب")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _deliveryPos, zoom: 15),
        onMapCreated: (controller) => mapController = controller,
        markers: {
          Marker(
            markerId: const MarkerId('delivery_man'),
            position: _deliveryPos,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            infoWindow: const InfoWindow(title: "المندوب قادم إليك"),
          ),
        },
      ),
    );
  }
}
