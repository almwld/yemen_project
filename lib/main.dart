import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemen_market/logic/cubits/language_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            locale: locale,
            debugShowCheckedModeBanner: false,
            title: 'يمن ماركت',
            theme: ThemeData(
              primarySwatch: Colors.red,
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.grey[100],
            ),
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // قائمة الصفحات الرئيسية
  final List<Widget> _pages = [
    const HomePage(),
    const CategoriesPage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red[900],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'الأقسام'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'الدردشة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

// --- صفحة الرئيسية مع البحث والسلة ---
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Container(
          height: 40,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'ابحث في يمن ماركت...',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart, color: Colors.white)),
              Positioned(right: 8, top: 8, child: CircleAvatar(radius: 8, backgroundColor: Colors.orange, child: Text('0', style: TextStyle(fontSize: 10)))),
            ],
          ),
        ],
      ),
      body: const Center(child: Text('هنا ستظهر أحدث الإعلانات')),
    );
  }
}

// --- صفحة الأقسام ---
class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('الأقسام')),
    body: GridView.count(
      crossAxisCount: 3,
      children: List.generate(9, (index) => Card(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.category, color: Colors.red), Text('قسم $index')]))),
    ),
  );
}

// --- صفحة الدردشة ---
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('الرسائل')),
    body: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text('بائع يمني $index'),
        subtitle: const Text('هل المنتج لا يزال متوفراً؟'),
        trailing: const Text('12:00 م'),
      ),
    ),
  );
}

// --- صفحة الحساب والإعدادات ---
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('الملف الشخصي')),
    body: Column(
      children: [
        const SizedBox(height: 20),
        const Center(child: CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50))),
        const Text('مستخدم يمن ماركت', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Divider(),
        ListTile(leading: const Icon(Icons.settings), title: const Text('إعدادات التطبيق'), onTap: () {}),
        ListTile(leading: const Icon(Icons.language), title: const Text('تغيير اللغة'), onTap: () {}),
        ListTile(leading: const Icon(Icons.help_outline), title: const Text('مركز المساعدة'), onTap: () {}),
        ListTile(leading: const Icon(Icons.logout, color: Colors.red), title: const Text('تسجيل الخروج'), onTap: () {}),
      ],
    ),
  );
}
