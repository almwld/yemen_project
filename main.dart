import 'package:flutter/material.dart';

void main() => runApp(YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        primaryColor: Colors.amber,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("مرحباً بك في", style: TextStyle(fontSize: 20, color: Colors.white70)),
            Text("يمن ماركت", style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.amber)),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: "رقم الهاتف أو البريد",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: Icon(Icons.person, color: Colors.amber),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "كلمة المرور",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: Icon(Icons.lock, color: Colors.amber),
              ),
            ),
            SizedBox(height: 30),
            // زر تسجيل الدخول
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // مستقبلاً نربطه بقاعدة البيانات
                },
                child: Text("تسجيل الدخول", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 15),
            // الخطوة الجديدة: زر الدخول كضيف
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.amber),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // الانتقال المباشر للرئيسية كضيف
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScaffold()));
                },
                child: Text("الدخول كضيف", style: TextStyle(color: Colors.amber, fontSize: 16)),
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: Text("أو عبر التواصل الاجتماعي", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}

// الواجهة الرئيسية التي سينتقل إليها الضيف
class MainScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("يمن ماركت (وضع الضيف)"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront, size: 100, color: Colors.amber),
            SizedBox(height: 20),
            Text("مرحباً بك أيها الضيف!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("يمكنك تصفح المنتجات الآن، ولكن ستحتاج للتسجيل لإتمام عمليات الشراء.", 
                textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
              child: Text("تسجيل الدخول الآن"),
            )
          ],
        ),
      ),
    );
  }
}
