#!/bin/bash
# 1. إنشاء المجلدات والملفات (بدون تشغيل فلاتر محلياً)
mkdir -p lib

# كتابة كود الواجهة الاحترافية (التي اتفقنا عليها)
cat > lib/home_screen.dart <<'EOD'
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F2F5),
      appBar: AppBar(
        title: Text("لوحة التحكم الذكية", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.indigo[900],
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.account_circle, size: 50, color: Colors.white),
                    Text("أهلاً بك في نظامك المتكامل", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _card(Icons.shopping_cart, "المتجر", Colors.orange),
                  _card(Icons.analytics, "الإحصائيات", Colors.blue),
                  _card(Icons.settings, "الإعدادات", Colors.grey),
                  _card(Icons.support_agent, "الدعم", Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
EOD

# 2. تحديث ملف التشغيل الرئيسي
cat > lib/main.dart <<'EOD'
import 'package:flutter/material.dart';
import 'home_screen.dart';
void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
EOD

# 3. الرفع للسيرفر مباشرة (تجاوز فلاتر المحلي)
echo "Syncing with GitHub/Server..."
git add .
git commit -m "Update: Professional UI Dashboard"
git push origin main
echo -e "\n\033[1;32m[+] Done! Now check your Remote Builder (GitHub/Codemagic).\033[0m"
