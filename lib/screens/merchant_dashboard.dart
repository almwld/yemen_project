import 'package:flutter/material.dart';
import 'add_product_screen.dart';
import 'seller_dashboard_screen.dart';

class MerchantDashboard extends StatelessWidget {
  final Color goldColor = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("لوحة تحكم التاجر", style: TextStyle(color: goldColor)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: goldColor),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            _buildDashboardCard(
              context, 
              "إضافة منتج جديد", 
              Icons.add_photo_alternate_outlined, 
              AddProductScreen()
            ),
            _buildDashboardCard(
              context, 
              "إدارة منتجاتي", 
              Icons.inventory_2_outlined, 
              SellerDashboardScreen()
            ),
            _buildDashboardCard(
              context, 
              "طلبات الزبائن", 
              Icons.shopping_cart_checkout, 
              null // يمكن ربطه بصفحة الطلبات لاحقاً
            ),
            _buildDashboardCard(
              context, 
              "إحصائيات المبيعات", 
              Icons.bar_chart_outlined, 
              null
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, IconData icon, Widget? nextScreen) {
    return InkWell(
      onTap: () {
        if (nextScreen != null) {
          Navigator.push(context, MaterialPageRoute(builder: (c) => nextScreen));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("هذه الميزة قيد التفعيل التقني"), backgroundColor: goldColor),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: goldColor.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: goldColor, size: 50),
            SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
