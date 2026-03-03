import 'package:flutter/material.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  String selectedFilter = "الكل";
  final List<String> filters = ["الكل", "عقارات", "سيارات", "ستارلينك", "صرافين"];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // محاكاة الخريطة (حتى نربط Google Maps API)
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://www.google.com/maps/d/u/0/thumbnail?mid=1h9vUu6G9K1N7T5uYf5Wl8L8rF9w"),
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: const Center(
            child: Icon(Icons.location_on, color: Color(0xFFD4AF37), size: 50),
          ),
        ),

        // شريط الفلاتر العلوي
        Positioned(
          top: 20,
          left: 10,
          right: 10,
          child: Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              reverse: true, // ليدعم اللغة العربية
              itemCount: filters.length,
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ChoiceChip(
                  label: Text(filters[i]),
                  selected: selectedFilter == filters[i],
                  onSelected: (val) => setState(() => selectedFilter = filters[i]),
                  selectedColor: const Color(0xFFD4AF37),
                  backgroundColor: Colors.black87,
                  labelStyle: TextStyle(color: selectedFilter == filters[i] ? Colors.black : Colors.white),
                ),
              ),
            ),
          ),
        ),

        // دبوس عقار محاكى (صنعاء - حدة)
        Positioned(
          top: 300,
          right: 150,
          child: InkWell(
            onTap: () => _showPropertyPreview(context),
            child: const Icon(Icons.location_on, color: Color(0xFFD4AF37), size: 40),
          ),
        ),

        // زر الموقع الحالي
        Positioned(
          bottom: 120,
          right: 20,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.black,
            onPressed: () {},
            child: const Icon(Icons.my_location, color: Color(0xFFD4AF37)),
          ),
        ),
      ],
    );
  }

  void _showPropertyPreview(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFD4AF37))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("فيلا ملكية للبيع", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text("حدة، خلف فندق شيراتون", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text("120,000\$", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Container(width: 80, height: 80, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white10)),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 45)),
              onPressed: () {},
              child: const Text("فتح الإعلان بالكامل", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
