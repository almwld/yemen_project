import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: IntegratedDashboard(),
));

class IntegratedDashboard extends StatelessWidget {
  const IntegratedDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('سوق اليمن المطور', style: TextStyle(color: Color(0xFFFFC107))),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن عقيق، بن، سيارات...',
                prefixIcon: const Icon(Icons.search, color: Colors.amber),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons. Map_outlined, size: 100, color: Colors.amber),
            const Text('تم تحديث الواجهة بنجاح!', style: TextStyle(color: Colors.white, fontSize: 20)),
            ElevatedButton(
              onPressed: () {}, 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('اطلب عبر واتساب'),
            )
          ],
        ),
      ),
    );
  }
}
