import 'package:flutter/material.dart';

class MerchantProfile extends StatelessWidget {
  final String name;
  MerchantProfile({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(name),
              background: Container(color: Colors.amber),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statItem("مبيعات", "120"),
                      _statItem("تقييم", "4.9"),
                      _statItem("توثيق", "ممتاز"),
                    ],
                  ),
                  Divider(),
                  Text("جميع عروض هذا التاجر", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: Container(width: 50, height: 50, color: Colors.grey[900]),
                title: Text("سلعة رقم ${index + 1}"),
                subtitle: Text("السعر: 15,000 ريال"),
                trailing: Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () => Navigator.pushNamed(context, '/ad_details'),
              ),
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
