import 'package:flutter/material.dart';

class AdvancedSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text("تصفية النتائج", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
          const SizedBox(height: 20),
          _searchField("المنطقة (مثلاً: الأصبحي، حدة)", Icons.location_city),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _searchField("إلى سعر", Icons.attach_money)),
              const SizedBox(width: 10),
              Expanded(child: _searchField("من سعر", Icons.money)),
            ],
          ),
          const SizedBox(height: 15),
          _searchField("عدد الغرف", Icons.bed),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
              onPressed: () => Navigator.pop(context),
              child: const Text("تطبيق الفلتر", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchField(String hint, IconData icon) => TextField(
    textAlign: TextAlign.right,
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFFD4AF37), size: 20),
      filled: true,
      fillColor: Colors.black26,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    ),
  );
}
