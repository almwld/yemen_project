import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MallMapScreen extends StatefulWidget {
  @override
  _MallMapScreenState createState() => _MallMapScreenState();
}

class _MallMapScreenState extends State<MallMapScreen> {
  GoogleMapController? _mapController;
  LatLng _userLocation = LatLng(15.30, 44.20); // موقع افتراضي (صنعاء)
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMallMarkers();
  }

  void _setMallMarkers() {
    // إضافة المولات التي وجدناها كعلامات على الخريطة
    setState(() {
      _markers.add(Marker(markerId: MarkerId('1'), position: LatLng(15.3349, 44.1976), infoWindow: InfoWindow(title: 'يمن مول')));
      _markers.add(Marker(markerId: MarkerId('2'), position: LatLng(15.2859, 44.2366), infoWindow: InfoWindow(title: 'مجمع الشلال التجاري', snippet: 'اضغط للملاحة', onTap: () => _launchNavigation(15.2859, 44.2366))));
      _markers.add(Marker(markerId: MarkerId('3'), position: LatLng(15.3351, 44.1989), infoWindow: InfoWindow(title: 'مول العرب')));
      _markers.add(Marker(markerId: MarkerId('4'), position: LatLng(15.2836, 44.2092), infoWindow: InfoWindow(title: 'عالم التسوق')));
      _markers.add(Marker(markerId: MarkerId('5'), position: LatLng(15.2905, 44.1989), infoWindow: InfoWindow(title: 'سما مول')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المراكز التجارية القريبة", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _userLocation, zoom: 12),
        onMapCreated: (controller) => _mapController = controller,
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}

Future<void> _launchNavigation(double lat, double lng) async {
  final url = 'google.navigation:q=$lat,$lng';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch navigation';
  }
}
