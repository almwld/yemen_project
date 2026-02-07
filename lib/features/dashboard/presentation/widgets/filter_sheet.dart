import 'package:flutter/material.dart';

class FilterSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('تصفية النتائج', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(color: Colors.white10),
          _buildFilterOption('المدينة', ['صنعاء', 'عدن', 'تعز', 'إب']),
          _buildFilterOption('نطاق السعر', ['أقل من 10,000', '10,000 - 50,000', 'أكثر من 50,000']),
          _buildFilterOption('شركة التوصيل', ['مزايا (سريع)', 'ماكس', 'توصيل']),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(double.infinity, 50)),
            onPressed: () => Navigator.pop(context),
            child: Text('تطبيق الفلتر', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title, style: TextStyle(color: Colors.white70)),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: options.map((opt) => Container(
              margin: EdgeInsets.only(left: 8),
              child: ChoiceChip(
                label: Text(opt),
                selected: false,
                onSelected: (val) {},
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }
}
