import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // تضمن أن كل أدوات فلاتر جاهزة قبل أي عملية برمجية
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // محاولة تشغيل فايربيس
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase Error: $e");
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: AuthWrapper(),
      ),
    ),
  );
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // صمام أمان: إذا لم يعمل الفايربيس، لا تظهر شاشة سوداء بل اظهر شاشة تحميل
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) {
          return MainNavigation();
        }
        return LoginScreen();
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00796B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text("يمن ماركت", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInAnonymously();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("خطأ: تأكد من تفعيل الدخول كضيف في الفايربيس")));
                }
              },
              child: Text("الدخول كضيف"),
              style: ElevatedButton.styleFrom(foregroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;
  final screens = [
    Scaffold(body: Center(child: Text("مرحباً بك في المتجر"))), // سنقوم بربطها لاحقاً
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "السلة"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
        ],
      ),
    );
  }
}
