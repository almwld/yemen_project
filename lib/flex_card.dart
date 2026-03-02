import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlexMenuCard extends StatelessWidget {
  final String title;
  final String svgPath; // مسار ملف الـ SVG (مثلاً: assets/icons/car.svg)
  final VoidCallback onTap;

  const FlexMenuCard({
    required this.title,
    required this.svgPath,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A), // الأسود الفخم
          borderRadius: BorderRadius.circular(22), // زوايا دائرية احترافية
          border: Border.all(
            color: const Color(0xFFD4AF37).withOpacity(0.2), // حدود ذهبية خفيفة
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // محرك عرض الـ SVG مع تلوينه بالذهبي
            SvgPicture.asset(
              svgPath,
              width: 35,
              height: 35,
              colorFilter: const ColorFilter.mode(
                Color(0xFFD4AF37), // تلوين الأيقونة بالذهبي الملكي
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
