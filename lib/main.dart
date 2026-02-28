import 'package:flutter/material.dart';
import 'screens/admin_panel_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // ملاحظة: قمنا بتعطيل فحص الدخول لفتح التطبيق فوراً
  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'فلكس يمن - الإدارة',
      theme: FlexTheme.darkGoldenTheme,
      debugShowCheckedModeBanner: false,
      // الدخول المباشر للوحة التحكم (Admin Panel)
      home: const AdminPanelScreen(), 
    );
  }
}
