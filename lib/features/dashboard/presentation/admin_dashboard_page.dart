import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 4;

  // واجهة صفحة الإعدادات الحقيقية
  Widget _buildSettingsPage() {
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.orange[800]),
          accountName: Text("مستخدم فليكس يمن"),
          accountEmail: Text("Yemen@market.com"),
          currentAccountPicture: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, size: 50, color: Colors.orange)),
        ),
        _settingsTile(Icons.dark_mode, "الثيم الليلي", "يتبع إعدادات الجهاز حالياً"),
        _settingsTile(Icons.info_outline, "عن المنصة", "تعرف على فليكس يمن ماركت", onTap: () => _showAboutDialog()),
        _settingsTile(Icons.privacy_tip_outlined, "سياسة الخصوصية", "كيف نحمي بياناتك"),
        _settingsTile(Icons.language, "اللغة", "العربية"),
        _settingsTile(Icons.contact_support_outlined, "اتصل بنا", "الدعم الفني المباشر"),
        Divider(),
        _settingsTile(Icons.logout, "تسجيل الخروج", "", color: Colors.red),
      ],
    );
  }

  ListTile _settingsTile(IconData icon, String title, String subtitle, {Color? color, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.orange[800]),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: onTap ?? () => print("فتح $title"),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: "فليكس يمن ماركت",
      applicationVersion: "1.0.0",
      applicationIcon: Icon(Icons.shop, color: Colors.orange),
      children: [Text("أول منصة يمنية شاملة للمزادات والبيع المباشر في اليمن.")],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("فليكس يمن ماركت"),
        centerTitle: true,
        backgroundColor: isDark ? Colors.grey[900] : Colors.orange[800],
      ),
      body: _selectedIndex == 0 ? _buildSettingsPage() : Center(child: Text("مرحباً بك في سوق اليمن")),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange[800],
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "المفضلة"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40), label: "أضف"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "استكشف"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
        ],
      ),
    );
  }
}
