import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('تتبع مندوب التوصيل'), backgroundColor: Colors.white10),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(15.3351, 44.1989), zoom: 14),
            markers: {
              Marker(markerId: MarkerId('merchant'), position: LatLng(15.3400, 44.2000), infoWindow: InfoWindow(title: 'موقع التاجر')),
              Marker(markerId: MarkerId('driver'), position: LatLng(15.3370, 44.1990), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure), infoWindow: InfoWindow(title: 'المندوب (مزايا)')),
              Marker(markerId: MarkerId('customer'), position: LatLng(15.3300, 44.1950), infoWindow: InfoWindow(title: 'منزلك')),
            },
          ),
          Positioned(
            bottom: 20, left: 10, right: 10,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.delivery_dining, color: Colors.black)),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('المندوب: أحمد (شركة ماكس)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text('يصل إليك خلال: ١٢ دقيقة', style: TextStyle(color: Colors.green, fontSize: 12)),
                    ],
                  ),
                  Spacer(),
                  IconButton(icon: Icon(Icons.phone, color: Colors.green), onPressed: () {}),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
