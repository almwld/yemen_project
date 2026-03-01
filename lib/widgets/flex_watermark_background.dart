import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlexWatermarkBackground extends StatelessWidget {
  final Widget child;
  const FlexWatermarkBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // لون ذهبي خفيف جداً وشبه شفاف للعلامة المائية
    final Color watermarkColor = const Color(0xFFD4AF37).withOpacity(0.015);

    return Stack(
      children: [
        // الطبقة 1: الخلفية السوداء العميقة
        Container(color: Colors.black),
        
        // الطبقة 2: النسيج المكرر (Monogram)
        IgnorePointer( // لكي لا تتداخل العلامة المائية مع اللمس
          child: Transform.rotate(
            angle: -math.pi / 12, // تدوير خفيف لإعطاء حركة
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // منع التمرير للنسيج
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // عدد الكلمات في الصف
                  childAspectRatio: 2, // تناسب العرض والارتفاع للكلمة
                ),
                itemCount: 100, // عدد التكرارات (يكفي لتغطية الشاشة)
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      "FLEX",
                      style: TextStyle(
                        color: watermarkColor,
                        fontSize: 10, // حجم صغير جداً
                        fontWeight: FontWeight.w900, // خط عريض جداً
                        fontFamily: 'Montserrat', // يفضل استخدام خط هندسي قوي
                        letterSpacing: 3, // تباعد بين الحروف
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        
        // الطبقة 3: المحتوى الأصلي للتطبيق
        child,
      ],
    );
  }
}
