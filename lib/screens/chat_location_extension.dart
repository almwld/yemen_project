import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

// دالة جلب وإرسال الموقع داخل الدردشة
Future<void> sendCurrentLocation(String orderId, String myId, supabase) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return;

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;
  }

  Position position = await Geolocator.getCurrentPosition();
  String mapUrl = "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";

  // إرسال رابط الموقع كرسالة نصية في الدردشة
  await supabase.from('messages').insert({
    'order_id': orderId,
    'sender_id': myId,
    'content': "📍 موقعي الحالي: $mapUrl",
  });
}
