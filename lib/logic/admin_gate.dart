import 'package:flutter/material.dart';
import '../screens/admin_dashboard.dart';

class AdminGate {
  static const String masterEmail = "Binobaeid@gmail.com";

  static void checkAccess(BuildContext context, String userEmail) {
    if (userEmail == masterEmail) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("عذراً، هذه المنطقة مخصصة لإدارة المنصة فقط."))
      );
    }
  }
}
