import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';

class ProfitDashboard extends StatelessWidget {
  const ProfitDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إحصائيات الأرباح الذهبية")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // كروت الملخص السريع
            Row(
              children: [
                _buildStatCard("مبيعات اليوم", "150,000 ر.ي", Icons.trending_up),
                const SizedBox(width: 10),
                _buildStatCard("طلبات جديدة", "12", Icons.shopping_cart),
              ],
            ),
            const SizedBox(height: 20),
            
            // الرسم البياني للأرباح
            Container(
              height: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFD4AF37), width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("نمو الأرباح (أسبوعي)", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              const FlSpot(0, 3), const FlSpot(1, 1),
                              const FlSpot(2, 4), const FlSpot(3, 3),
                              const FlSpot(4, 5), const FlSpot(5, 4),
                              const FlSpot(6, 8),
                            ],
                            isCurved: true,
                            gradient: FlexTheme.goldenGradient,
                            barWidth: 5,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [const Color(0xFFD4AF37).withOpacity(0.3), Colors.transparent],
                                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFB38728)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFD4AF37)),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
