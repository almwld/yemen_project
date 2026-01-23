import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'services/guest_auth_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GuestAuthService.signIn();
  runApp(const YemenMarketApp());
}
