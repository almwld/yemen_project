import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/auctions_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/real_estate_screen.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  @override
  _FlexYemenAppState createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flex Yemen Market',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      // شاشة الترحيب هي البداية الآن بدون معاملات معقدة
      home: SplashScreen(), 
    );
  }
}

// هذه هي الشاشة الرئيسية التي سينتقل إليها التطبيق بعد شاشة الترحيب
class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("فلكس يمن ماركت", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCategoryCard(context, "سوق العقارات", Icons.home_work, Colors.green, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RealEstateScreen()));
            }),
            _buildCategoryCard(context, "ساحة المزايدات", Icons.gavel, Colors.redAccent, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AuctionsScreen()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            SizedBox(width: 20),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
