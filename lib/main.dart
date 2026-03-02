import 'package:flutter/material.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        primaryColor: Colors.amber,
      ),
      home: MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 4; // نبدأ بصفحة الحساب كما في طلبك

  final List<Widget> _pages = [
    Center(child: Text("الرئيسية")),
    Center(child: Text("استكشف")),
    Center(child: Text("أضف إعلان")),
    Center(child: Text("المفضلة")),
    AccountSettingsScreen(), // صفحة الحساب المبرمجة
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'استكشف'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'أضف'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'حسابي'),
        ],
      ),
    );
  }
}

// واجهة إعدادات الحساب (نفس الصورة المرفقة)
class AccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إعدادات الحساب", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // رأس الحساب (User Profile Header)
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.person, size: 40, color: Colors.black),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("اسم المستخدم", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text("ID: 2026889", style: TextStyle(color: Colors.amber, fontSize: 12)),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.edit_note, color: Colors.amber),
              ],
            ),
          ),

          _buildSectionTitle("إدارة الأموال"),
          _buildSettingsItem(Icons.account_balance_wallet, "المحفظة المالية", "رصيدك، شحن، سحب أرباح", context),
          _buildSettingsItem(Icons.history, "سجل العمليات", "تفاصيل المبيعات والمشتريات", context),

          _buildSectionTitle("التوثيق والأمان"),
          _buildSettingsItem(Icons.verified_user, "(KYC) توثيق الهوية", "ارفع بطاقتك للحصول على العلامة الزرقاء", context),
          _buildSettingsItem(Icons.lock, "تغيير كلمة المرور", "تحديث بيانات الدخول", context),

          _buildSectionTitle("إعدادات التطبيق"),
          _buildSettingsItem(Icons.language, "لغة التطبيق", "العربية (اليمن)", context),
          _buildSettingsItem(Icons.notifications, "إعدادات التنبيهات", "التحكم في وصول الإشعارات", context),

          _buildSectionTitle("الدعم الفني"),
          _buildSettingsItem(Icons.headset_mic, "اتصل بنا", "واتساب، إيميل، اتصال مباشر", context),
          
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(title, style: TextStyle(color: Colors.grey, fontSize: 14)),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle, BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: Colors.amber),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        // هنا يتم فتح النوافذ الفرعية
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فتح $title...")));
      },
    );
  }
}
