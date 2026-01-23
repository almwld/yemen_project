import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('السوق اليمني'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/services'),
              child: const Text('🛍️ جميع الخدمات'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/chat'),
              child: const Text('💬 الدردشة الذكية'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/settings'),
              child: const Text('⚙️ الإعدادات'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/admin-dashboard'),
              child: const Text('🧭 لوحة تحكم الإدارة'),
            ),
          ],
        ),
      ),
    );
  }
}
