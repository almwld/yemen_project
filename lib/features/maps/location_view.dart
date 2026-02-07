import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationView extends StatelessWidget {
  final LatLng location;
  const LocationView({required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: location, zoom: 14),
          markers: {Marker(markerId: MarkerId('p1'), position: location)},
          liteModeEnabled: true, // لوضع معاينة خفيفة
        ),
      ),
    );
  }
}
