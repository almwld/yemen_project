import 'package:flutter/material.dart';
import 'features/dashboard/presentation/admin_dashboard_page.dart';

void main() {
  runApp(YemenMarketApp());
}

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'فليكس يمن ماركت',
      debugShowCheckedModeBanner: false,
      // تفعيل الثيم الليلي والنهاري حسب إعدادات الجهاز
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      themeMode: ThemeMode.system, 
      home: AdminDashboardPage(),
    );
  }
}
