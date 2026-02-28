import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TrackingScreen extends StatefulWidget {
  final String orderId;
  const TrackingScreen({super.key, required this.orderId});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  LatLng _deliveryBoyPos = const LatLng(15.3694, 44.1910); // موقع افتراضي في صنعاء
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _listenToDeliveryLocation();
  }

  // الاستماع لتحديثات الموقع من سوبابيس (Real-time)
  void _listenToDeliveryLocation() {
    Supabase.instance.client
        .from('deliveries')
        .stream(primaryKey: ['id'])
        .eq('order_id', widget.orderId)
        .listen((data) {
          if (data.isNotEmpty) {
            setState(() {
              _deliveryBoyPos = LatLng(data.first['lat'], data.first['lng']);
              _mapController?.animateCamera(CameraUpdate.newLatLng(_deliveryBoyPos));
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تتبع طلبك - فلكس يمن")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _deliveryBoyPos, zoom: 15),
            onMapCreated: (controller) => _mapController = controller,
            markers: {
              Marker(
                markerId: const MarkerId('deliveryBoy'),
                position: _deliveryBoyPos,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow), // أيقونة ذهبية للشاحنة
              ),
            },
          ),
          Positioned(
            bottom: 20, left: 20, right: 20,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.gold)),
              child: const Row(
                children: [
                  Icon(Icons.delivery_dining, color: Colors.gold),
                  SizedBox(width: 10),
                  Text("المندوب في طريقه إليك...", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
