import 'package:flutter/material.dart';
import '../services/upload_service.dart';
import '../services/sound_service.dart';
import '../theme/app_theme.dart';
import 'profit_dashboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});
  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  String? _imageUrl;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة التاجر الملكية"),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Color(0xFFD4AF37)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfitDashboard())),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // بطاقة التقارير الذهبية
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfitDashboard())),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFFD4AF37), width: 1),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.insights, color: const Color(0xFFD4AF37), size: 30),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("تقارير الأرباح والمبيعات", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text("اضغط لعرض الرسم البياني", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: const Color(0xFFD4AF37), size: 15),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // حقول إضافة المنتج...
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "اسم المنتج")),
            const SizedBox(height: 10),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: "السعر"), keyboardType: TextInputType.number),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(gradient: FlexTheme.goldenGradient, borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                onPressed: () async {
                   // منطق الحفظ وصوت الكاشير
                   await SoundService.playCashSound();
                },
                child: const Text("نشر المنتج 💰", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
