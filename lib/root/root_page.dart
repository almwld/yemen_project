import 'package:flutter/material.dart';
import '../features/home/home_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    // الدخول مباشرة إلى السوق
    return const HomePage();
  }
}
