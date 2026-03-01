import 'package:flutter/material.dart';

Widget buildGoldProductCard(Map<String, dynamic> p, Color gold, VoidCallback onTap) {
  bool isFeatured = p['is_featured'] ?? false;
  
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: isFeatured ? gold : gold.withOpacity(0.1), 
        width: isFeatured ? 2 : 1
      ),
      boxShadow: isFeatured ? [BoxShadow(color: gold.withOpacity(0.2), blurRadius: 10)] : null,
    ),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container(color: Colors.white05, child: const Center(child: Icon(Icons.image, color: Colors.white24)))),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1),
                  Text("${p['price']} ريال", style: TextStyle(color: gold, fontSize: 11)),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: gold, minimumSize: const Size(double.infinity, 25)),
                    onPressed: onTap,
                    child: const Text("مراسلة", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (isFeatured)
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(5)),
              child: const Icon(Icons.star, size: 12, color: Colors.black),
            ),
          ),
      ],
    ),
  );
}
