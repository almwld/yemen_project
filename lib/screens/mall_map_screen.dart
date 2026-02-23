import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MallMapScreen extends StatefulWidget {
  @override
  _MallMapScreenState createState() => _MallMapScreenState();
}

class _MallMapScreenState extends State<MallMapScreen> {
  GoogleMapController? _mapController;
  LatLng _userLocation = LatLng(15.30, 44.20);
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMallMarkers();
  }

  void _setMallMarkers() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('1'), 
        position: LatLng(15.2859, 44.2366), 
        infoWindow: InfoWindow(
          title: 'مجمع الشلال التجاري',
          onTap: () => _launchNavigation(15.2859, 44.2366)
        )
      ));
    });
  }

  Future<void> _launchNavigation(double lat, double lng) async {
    final Uri url = Uri.parse('google.navigation:q=$lat,$lng');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("خرائط المولات", style: TextStyle(color: Colors.amber))),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _userLocation, zoom: 12),
        onMapCreated: (controller) => _mapController = controller,
        markers: _markers,
      ),
    );
  }
}
