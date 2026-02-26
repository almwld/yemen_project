import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatefulWidget {
  const FlexYemenApp({super.key});

  @override
  State<FlexYemenApp> createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  // الحالة الافتراضية هي الوضع الليلي (Dark)
  ThemeMode _themeMode = ThemeMode.dark;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    
    return MaterialApp(
      title: 'Flex Yemen',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      
      // الثيم النهاري (Light Theme)
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: gold,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white, iconTheme: IconThemeData(color: Colors.black)),
      ),
      
      // الثيم الليلي (Dark Theme)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: gold,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black, iconTheme: IconThemeData(color: gold)),
      ),

      home: Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(onThemeToggle: toggleTheme),
      ),
    );
  }
}
