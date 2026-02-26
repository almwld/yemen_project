import 'package:flutter/material.dart';

class FlexSearchDelegate extends SearchDelegate {
  final List<String> searchTerms = [
    "تويوتا كورولا",
    "شقة للإيجار حدة",
    "آيفون 15 برو",
    "مرسيدس بنز",
    "أرض للبيع في صنعاء",
    "لاب توب ديل",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Color(0xFFD4AF37)),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Color(0xFFD4AF37)),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in searchTerms) {
      if (item.contains(query)) {
        matchQuery.add(item);
      }
    }
    return _buildSearchList(matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in searchTerms) {
      if (item.contains(query)) {
        matchQuery.add(item);
      }
    }
    return _buildSearchList(matchQuery);
  }

  Widget _buildSearchList(List<String> results) {
    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(results[index], style: const TextStyle(color: Colors.white)),
            leading: const Icon(Icons.history, color: Colors.white24),
            onTap: () {
              query = results[index];
              showResults(context);
            },
          );
        },
      ),
    );
  }
}
