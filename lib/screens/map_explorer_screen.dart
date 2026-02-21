import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapExplorerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("خريطة المتاجر الموثقة")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(15.3694, 44.1910), // إحداثيات صنعاء
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.flexyemen.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(15.3349, 44.1976), // مثال لموقع متجر (يمن مول)
                child: Icon(Icons.verified, color: Colors.blue, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
