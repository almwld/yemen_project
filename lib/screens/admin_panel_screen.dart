import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminPanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Text("إحصائيات فلكس يمن", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("معدل نمو الأرباح الإسبوعي", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            
            // الرسم البياني للأرباح
            Container(
              height: 200,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20)),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 3), FlSpot(1, 1), FlSpot(2, 4), 
                        FlSpot(3, 2), FlSpot(4, 5), FlSpot(5, 3), FlSpot(6, 6),
                      ],
                      isCurved: true,
                      color: Colors.amber,
                      barWidth: 4,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: true, color: Colors.amber.withOpacity(0.1)),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 25),
            Text("توزيع الأقسام", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            
            // الرسم البياني الدائري لتوزيع المنتجات
            Container(
              height: 200,
              decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20)),
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: 40, color: Colors.blue, title: "سيارات", radius: 50),
                    PieChartSectionData(value: 30, color: Colors.green, title: "عقارات", radius: 50),
                    PieChartSectionData(value: 20, color: Colors.red, title: "مزادات", radius: 50),
                    PieChartSectionData(value: 10, color: Colors.amber, title: "أخرى", radius: 50),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25),
            _buildAdminStatsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminStatsRow() {
    return Row(
      children: [
        Expanded(child: _miniStatCard("المستخدمين الجدد", "+124", Colors.blue)),
        SizedBox(width: 10),
        Expanded(child: _miniStatCard("عمولات اليوم", "15k ريال", Colors.green)),
      ],
    );
  }

  Widget _miniStatCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.white54, fontSize: 12)),
          Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
