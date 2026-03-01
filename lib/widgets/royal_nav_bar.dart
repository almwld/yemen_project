import 'package:flutter/material.dart';

class RoyalNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const RoyalNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    final Color inactive = Colors.grey[600]!;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [BoxShadow(color: gold.withOpacity(0.1), blurRadius: 20, spreadRadius: 2)],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // الـ 3 أزرار الأولى (يمين)
          _navItem(Icons.grid_view_rounded, 0, "السوق"),
          _navItem(Icons.search, 1, "بحث"),
          _navItem(Icons.notifications_none, 2, "تنبيه"),
          
          // الزر المركزي (الزائد) لرفع المنتجات
          GestureDetector(
            onTap: () => onTap(3), // رقم 3 مخصص للإضافة
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: gold,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: gold.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: const Icon(Icons.add, color: Colors.black, size: 35),
            ),
          ),

          // الـ 3 أزرار الأخيرة (يسار)
          _navItem(Icons.account_balance_wallet_outlined, 4, "محفظة"),
          _navItem(Icons.chat_bubble_outline, 5, "دردشة"),
          _navItem(Icons.person_outline, 6, "حسابي"),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index, String label) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? const Color(0xFFD4AF37) : Colors.grey[600], size: 26),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: isActive ? const Color(0xFFD4AF37) : Colors.grey[600], fontSize: 10)),
        ],
      ),
    );
  }
}
