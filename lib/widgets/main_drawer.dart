import 'package:flutter/material.dart';
import '../theme/flex_theme.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(gradient: FlexTheme.goldenGradient),
              currentAccountPicture: CircleAvatar(backgroundColor: Colors.black, child: Icon(Icons.person, color: gold, size: 40)),
              accountName: const Text("مستخدم فلكس يمن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              accountEmail: const Text("user@flexyemen.com", style: TextStyle(color: Colors.black54)),
            ),
            
            // زر التبديل بين الوضع الليلي والنهاري
            SwitchListTile(
              title: const Text("الوضع الليلي", style: TextStyle(color: Colors.white)),
              secondary: Icon(Icons.brightness_4, color: gold),
              value: true, // سيتم ربطه بـ ThemeProvider لاحقاً
              activeColor: gold,
              onChanged: (bool value) {
                // منطق تغيير الثيم
              },
            ),
            
            const Divider(color: Colors.white24),
            _buildItem(context, "الملف الشخصي", Icons.person_outline),
            _buildItem(context, "الدعم الفني", Icons.support_agent),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () => Navigator.pop(context),
    );
  }
}
