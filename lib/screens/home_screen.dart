import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  final bool isGuest;
  HomeScreen({this.isGuest = false});

  final List<Map<String, dynamic>> sections = [
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.blue},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.green},
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'color': Colors.orange},
    {'name': 'مواشي', 'icon': Icons.pets, 'color': Colors.brown},
    {'name': 'خدمات', 'icon': Icons.handyman, 'color': Colors.red},
    {'name': 'وظائف', 'icon': Icons.work, 'color': Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("فلكس يمن 🇾🇪"),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          if (!isGuest) IconButton(icon: Icon(Icons.person), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(isGuest ? "زائر" : "مستخدم فلكس"),
              accountEmail: Text(isGuest ? "تصفح محدود" : "حساب موثق"),
              currentAccountPicture: CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person)),
              decoration: BoxDecoration(color: Colors.black87),
            ),
            ListTile(leading: Icon(Icons.shopping_bag), title: Text("مشترياتي"), onTap: () {}),
            ListTile(leading: Icon(Icons.favorite), title: Text("المفضلة"), onTap: () {}),
            if (isGuest) ListTile(leading: Icon(Icons.login), title: Text("تسجيل الدخول"), onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // بنر ترحيبي ذكي
            _buildWelcomeBanner(),
            
            // شبكة الأقسام (Grid View) لسهولة الوصول
            Padding(
              padding: EdgeInsets.all(15),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10,
                ),
                itemCount: sections.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => _handleSectionTap(context, sections[index]['name']),
                    child: Container(
                      decoration: BoxDecoration(
                        color: sections[index]['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: sections[index]['color'].withOpacity(0.3)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(sections[index]['icon'], color: sections[index]['color'], size: 30),
                          SizedBox(height: 8),
                          Text(sections[index]['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // قسم "أحدث الإعلانات"
            _buildProductSection("أحدث العروض 🔥"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleAction(context, "إضافة إعلان"),
        label: Text("أضف إعلانك"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }

  void _handleSectionTap(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("جاري فتح قسم $name...")));
  }

  void _handleAction(BuildContext context, String action) {
    if (isGuest) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يرجى تسجيل الدخول أولاً للقيام بـ $action"), backgroundColor: Colors.red),
      );
    } else {
      // تنفيذ الإجراء للمسجلين
    }
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.amber, Colors.orange]),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("أهلاً بك في فلكس يمن", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("سوقك الآمن للبيع والشراء بالضمان"),
        ],
      ),
    );
  }

  Widget _buildProductSection(String title) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(padding: EdgeInsets.all(15), child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
         // محاكاة لقائمة المنتجات
         Container(height: 200, child: Center(child: Text("سيتم تحميل المنتجات من سوبابيس..."))),
       ],
     );
  }
}
