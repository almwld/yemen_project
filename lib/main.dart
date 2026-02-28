import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/admin_panel_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // تفعيل نظام السلة في كامل التطبيق
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const FlexYemenApp(),
    ),
  );
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'فلكس يمن',
      theme: FlexTheme.darkGoldenTheme,
      debugShowCheckedModeBanner: false,
      home: const AdminPanelScreen(), 
    );
  }
}
