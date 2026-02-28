import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'add_product_screen.dart';
import 'order_manager_screen.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة تحكم فلكس يمن"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Color(0xFFD4AF37)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen())),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildBtn(context, "إضافة منتج جديد", Icons.add_shopping_cart, const AddProductScreen()),
          const SizedBox(height: 15),
          _buildBtn(context, "إدارة الطلبات", Icons.delivery_dining, const OrderManagerScreen()),
        ],
      ),
    );
  }

  Widget _buildBtn(BuildContext context, String title, IconData icon, Widget screen) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 60)),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
      icon: Icon(icon),
      label: Text(title),
    );
  }
}
