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

// --- نموذج التقييم ---
class Review {
  final String username, comment, date;
  final double rating;
  Review({required this.username, required this.comment, required this.date, required this.rating});
}

// 1. واجهة التقييمات (Reviews Screen)
class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Review> reviews = [
      Review(username: "محمد اليافعي", comment: "المنتج ممتاز جداً والتوصيل كان سريع في صنعاء.", date: "منذ يومين", rating: 5.0),
      Review(username: "سارة العدني", comment: "الجودة جيدة جداً مقارنة بالسعر.", date: "منذ أسبوع", rating: 4.0),
      Review(username: "أحمد تعز", comment: "التغليف يحتاج تحسين بسيط لكن المنتج شغال تمام.", date: "منذ شهر", rating: 3.5),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('آراء المشترين')),
      body: Column(
        children: [
          // ملخص التقييمات العلوي
          _buildRatingSummary(),
          const Divider(),
          // قائمة التعليقات
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, i) => _buildReviewItem(reviews[i]),
            ),
          ),
          // زر إضافة تقييم
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {},
              icon: const Icon(Icons.rate_review, color: Colors.black),
              label: const Text('إضافة تقييمك', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSummary() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Column(
            children: [
              Text('4.2', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.amber)),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star_half, color: Colors.amber, size: 20),
                ],
              ),
              Text('بناءً على 150 تقييم', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(review.username, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(review.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < review.rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 16,
              );
            }),
          ),
          const SizedBox(height: 5),
          Text(review.comment, style: const TextStyle(height: 1.4)),
          const Divider(height: 30),
        ],
      ),
    );
  }
}

// 2. تحديث المحرك الرئيسي لربط الواجهة
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});
  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _index = 2;
  @override
  Widget build(BuildContext context) {
    final pages = [
      const ProfileScreen(),
      const Center(child: Text('الخريطة')),
      const HomeScreen(),
      const Center(child: Text('الدردشة')),
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
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'الخريطة'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'دردشة'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'مزادات'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ReviewsScreen())),
          child: const Text('عرض تقييمات المنتج (تجربة)'),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('الملف الشخصي'))); }
class WelcomeScreen extends StatelessWidget { const WelcomeScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(body: Center(child: ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigator())), child: const Text('دخول كضيف')))); }
