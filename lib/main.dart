import 'package:flutter/material.dart';

void main() => runApp(const YemenMarketApp());

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E1E1E), centerTitle: true),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// --- النماذج ---
class AppNotification {
  final String title, body, time;
  AppNotification({required this.title, required this.body, required this.time});
}

// --- البيانات العامة ---
List<AppNotification> notifications = [
  AppNotification(title: "مرحباً بك", body: "استكشف سوق اليمن الشامل الآن.", time: "الآن"),
];

// 1. صفحة الترحيب (الدخول كضيف)
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF1E1E1E), Colors.black])),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.storefront, size: 100, color: Colors.amber),
          const SizedBox(height: 20),
          const Text('سوق اليمن الشامل', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber)),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(250, 50)),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigator())),
            child: const Text('الدخول كضيف', style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
        ]),
      ),
    );
  }
}

// 2. المحرك الرئيسي للتنقل
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});
  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _index = 2; // البدء من الرئيسية
  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final pages = [
      ProfileScreen(refresh: _update),
      const Center(child: Text('المفضلة')),
      const HomeScreen(),
      const Center(child: Text('البحث')),
      const Center(child: Text('المزادات')),
    ];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'مفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'مزاد'),
        ],
      ),
    );
  }
}

// 3. الصفحة الرئيسية
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سوق اليمن'),
        leading: IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen())),
        ),
      ),
      body: const Center(child: Text('محتوى السوق يظهر هنا')),
    );
  }
}

// 4. صفحة الملف الشخصي (موسعة)
class ProfileScreen extends StatelessWidget {
  final VoidCallback refresh;
  const ProfileScreen({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات والمعلومات')),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const Center(child: CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40))),
          const Center(child: Text('زائر (Guest)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 20),
          _infoTile(context, Icons.info_outline, "عن سوق اليمن", const AboutUsScreen()),
          _infoTile(context, Icons.help_outline, "الأسئلة الشائعة", const FAQScreen()),
          _infoTile(context, Icons.description_outlined, "شروط الاستخدام", const PrivacyPolicyScreen()),
          _infoTile(context, Icons.contact_support_outlined, "تواصل مع الإدارة", null),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('خروج'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen())),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(BuildContext context, IconData icon, String title, Widget? page) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if (page != null) Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}

// 5. واجهة "عن التطبيق"
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عن سوق اليمن')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('سوق اليمن الشامل', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber)),
            SizedBox(height: 10),
            Text(
              'أكبر منصة يمنية متكاملة تهدف لربط البائع بالمشتري في جميع محافظات الجمهورية. نحن نسعى لتسهيل عملية التجارة الإلكترونية وتقديم خدمات المزاد العلني بأحدث التقنيات.',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// 6. واجهة "الأسئلة الشائعة"
class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final faqs = [
      {"q": "كيف يمكنني إضافة إعلان؟", "a": "اضغط على زر 'بيع' في القائمة السفلية واملأ بيانات السلعة."},
      {"q": "هل استخدام التطبيق مجاني؟", "a": "نعم، التصفح وعرض السلع مجاني تماماً."},
      {"q": "كيف أتواصل مع البائع؟", "a": "يمكنك الضغط على زر الواتساب أو الاتصال المباشر في صفحة السلعة."},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('الأسئلة الشائعة')),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, i) => ExpansionTile(
          title: Text(faqs[i]['q']!, style: const TextStyle(color: Colors.amber)),
          children: [Padding(padding: const EdgeInsets.all(15), child: Text(faqs[i]['a']!, textAlign: TextAlign.right))],
        ),
      ),
    );
  }
}

// 7. واجهة "الخصوصية والشروط"
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('شروط الاستخدام')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(
          '1. يمنع عرض السلع المحظورة قانوناً.\n'
          '2. المتجر غير مسؤول عن عمليات الاحتيال، ننصح بالمعاينة قبل الدفع.\n'
          '3. يجب أن تكون الصور حقيقية للسلعة المعروضة.\n'
          '4. يحق للإدارة حذف أي إعلان مخالف دون سابق إنذار.',
          textAlign: TextAlign.right,
          style: TextStyle(height: 2.0),
        ),
      ),
    );
  }
}

// 8. واجهة الإشعارات
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('التنبيهات')), body: const Center(child: Text('لا توجد تنبيهات حالياً')));
}
