import 'package:flutter/material.dart';
import 'dart:async';

class FeaturedSlider extends StatefulWidget {
  const FeaturedSlider({super.key});

  @override
  State<FeaturedSlider> createState() => _FeaturedSliderState();
}

class _FeaturedSliderState extends State<FeaturedSlider> {
  final PageController _controller = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  late Timer _timer;

  // قائمة الإعلانات الـ 7
  final List<Map<String, String>> _ads = [
    {'title': 'عروض الإلكترونيات', 'desc': 'خصم 20% على الهواتف', 'img': 'https://pqqpivfylzlybbtasvbw.supabase.co/storage/v1/object/public/ads/ad1.jpg'},
    {'title': 'عقارات صنعاء', 'desc': 'فلل فاخرة للبيع', 'img': 'https://pqqpivfylzlybbtasvbw.supabase.co/storage/v1/object/public/ads/ad2.jpg'},
    {'title': 'سيارات حديثة', 'desc': 'وصلت دفعات 2026', 'img': 'https://pqqpivfylzlybbtasvbw.supabase.co/storage/v1/object/public/ads/ad3.jpg'},
    {'title': 'خدمات فلكس', 'desc': 'توثيق الحسابات متاح الآن', 'img': 'https://pqqpivfylzlybbtasvbw.supabase.co/storage/v1/object/public/ads/ad4.jpg'},
    {'title': 'تخفيضات الملابس', 'desc': 'أزياء راقية بأقل الأسعار', 'img': 'https://pqqpivfylzlybbtasvbw.supabase.co/storage/v1/object/public/ads/ad5.jpg'},
    {'title': 'الركن التقني', 'desc': 'لابتوبات بضمانة حقيقية', 'img': 'https://pqqpivfylzlybbtasvbw.supabase.co/storage/v1/object/public/ads/ad6.jpg'},
    {'title': 'فلكس جولد', 'desc': 'اشترك في المميزات الملكية', 'img': 'https://pqqpivfylzlybbtasvbw.supabase.co/storage/v1/object/public/ads/ad7.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 6) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(_currentPage, duration: const Duration(milliseconds: 800), curve: Curves.easeInOutCubic);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _controller,
        itemCount: _ads.length,
        onPageChanged: (int page) => setState(() => _currentPage = page),
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double value = 1.0;
              if (_controller.position.haveDimensions) {
                value = _controller.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
              }
              return Center(
                child: SizedBox(
                  height: Curves.easeOut.transform(value) * 180,
                  width: Curves.easeOut.transform(value) * 400,
                  child: child,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: gold.withOpacity(0.1), blurRadius: 10, spreadRadius: 1)],
                gradient: LinearGradient(colors: [Colors.grey[900]!, Colors.black]),
                border: Border.all(color: gold.withOpacity(0.3), width: 0.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // هنا نضع الصورة (Image.network)
                    Opacity(opacity: 0.4, child: Icon(Icons.campaign, size: 80, color: gold)), 
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_ads[index]['title']!, style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
                          Text(_ads[index]['desc']!, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
