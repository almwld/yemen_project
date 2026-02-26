import 'package:flutter/material.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color gold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("FLEX YEMEN", style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        leading: IconButton(
          icon: Icon(Icons.settings_outlined, color: gold),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
        ),
        actions: [
          IconButton(icon: Icon(Icons.brightness_6_outlined, color: gold), onPressed: widget.onThemeToggle),
          IconButton(icon: Icon(Icons.notifications_none_outlined, color: gold), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Text("تم تحديث الواجهة بنجاح!", style: TextStyle(color: gold, fontSize: 18)),
      ),
    );
  }
}
