import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  final List<Map<String, String>> services = [
    {'title': '🏨 حجز فنادق', 'offer': 'خصم 20% هذا الأسبوع'},
    {'title': '✈️ حجز طيران', 'offer': 'أفضل سعر اليوم'},
    {'title': '💳 دفع إلكتروني', 'offer': 'عمولة 0%'},
    {'title': '🎮 شحن ألعاب', 'offer': 'Bonus VIP'},
    {'title': ' شحن رصيد', 'offer': 'عرض مغري'},
    {'title': '🌐 كروت إنترنت', 'offer': 'سرعة مضاعفة'},
    {'title': '₿ بيع وشراء كربيتو', 'offer': 'سعر خاص'},
    {'title': '🛒 مشتريات إلكترونية', 'offer': 'عروض جديدة'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛍️ جميع الخدمات'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Chip(
              label: Text(
                'VIP',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.amber,
            ),
          )
        ],
      ),
      body: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final item = services[index];
              return AnimatedContainer(
                duration: Duration(milliseconds: 300 + (index * 100)),
                curve: Curves.easeOut,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Colors.green, Colors.teal],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['offer']!,
                      style: const TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
