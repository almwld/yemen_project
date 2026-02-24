import 'package:flutter/material.dart';

class ProductSearchDelegate extends SearchDelegate {
  final List<String> recentSearches = ["تويوتا", "شقة في حدة", "آيفون 15", "جنابي", "مواشي"];

  @override
  String get searchFieldLabel => 'ابحث عن سيارات، عقارات، والمزيد...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: Colors.black),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
      textTheme: TextTheme(titleLarge: TextStyle(color: Colors.white)),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(icon: Icon(Icons.clear, color: Colors.amber), onPressed: () => query = ""),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    NotificationService.showInstantNotification("فلكس يمن 🔎", "تم العثور على أفضل العروض لـ $query في منطقتك!");
    // هنا يتم استدعاء البيانات من سوبابيس بناءً على الـ query
    return Center(
      child: Text("جاري البحث عن '$query' في سوق فلكس...", style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty 
        ? recentSearches 
        : recentSearches.where((element) => element.contains(query)).toList();

    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.history, color: Colors.amber),
          title: Text(suggestions[index], style: TextStyle(color: Colors.white)),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        ),
      ),
    );
  }
}
