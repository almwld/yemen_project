import '../services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Color gold = const Color(0xFFD4AF37);
  final supabase = Supabase.instance.client;
  
  String selectedCity = "الكل";
  String searchQuery = "";
  List<dynamic> searchResults = [];
  bool isLoading = false;

  final List<String> yemenCities = ["الكل", "صنعاء", "عدن", "تعز", "إب", "حضرموت", "الحديدة", "مأرب"];

  // دالة البحث الحقيقي من جداول سوبابيس
  Future<void> performSearch(String query) async {
    setState(() { isLoading = true; searchQuery = query; });
    
    try {
      var request = supabase.from('items').select(); // نفترض أن الجدول الرئيسي اسمه items
      
      // التصفية حسب النص
      if (query.isNotEmpty) {
        request = request.ilike('title', '%$query%');
      }
      
      // التصفية حسب المحافظة
      if (selectedCity != "الكل") {
        request = request.eq('city', selectedCity);
      }

      final data = await request.limit(20);
      setState(() { searchResults = data; isLoading = false; });
    } catch (e) {
      setState(() { isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          onChanged: (value) => performSearch(value),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "ابحث في $selectedCity...",
            hintStyle: TextStyle(color: gold.withOpacity(0.5)),
            suffixIcon: Icon(Icons.search, color: gold),
            border: InputBorder.none,
          ),
        ),
      ),
      body: Column(
        children: [
          // شريط المحافظات
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: yemenCities.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedCity == yemenCities[index];
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedCity = yemenCities[index]);
                    NotificationService.showNotification("تم تغيير المنطقة", "أنت الآن تتصفح أحدث العروض في $selectedCity");
                    performSearch(searchQuery);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: isSelected ? gold : Colors.grey[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(yemenCities[index], 
                        style: TextStyle(color: isSelected ? Colors.black : Colors.white)),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // نتائج البحث
          Expanded(
            child: isLoading 
              ? Center(child: CircularProgressIndicator(color: gold))
              : searchResults.isEmpty 
                ? Center(child: Text("لا توجد نتائج مطابقة", style: TextStyle(color: gold.withOpacity(0.5))))
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final item = searchResults[index];
                      return ListTile(
                        leading: Icon(Icons.shopping_bag_outlined, color: gold),
                        title: Text(item['title'] ?? '', style: const TextStyle(color: Colors.white)),
                        subtitle: Text(item['city'] ?? '', style: TextStyle(color: gold.withOpacity(0.7))),
                        trailing: Text("${item['price']} ريال", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
