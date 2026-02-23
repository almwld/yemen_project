import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WalletScreen extends StatelessWidget {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    // جلب بيانات المستخدم الحالي (الرصيد والاسم)
    final user = supabase.auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("محفظة فلكس يمن", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<Map<String, dynamic>>(
        // الربط المباشر مع جدول البروفايل للحصول على الرصيد
        stream: supabase
            .from('profiles')
            .stream(primaryKey: ['id'])
            .eq('id', user?.id ?? '')
            .map((list) => list.first),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator(color: Colors.amber));

          final data = snapshot.data!;
          final balance = data['wallet_balance'] ?? 0;

          return Column(
            children: [
              // كارت الرصيد الفخم
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(30),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber[700]!, Colors.amber[400]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: Colors.amber.withOpacity(0.3), blurRadius: 20, offset: Offset(0, 10))
                  ],
                ),
                child: Column(
                  children: [
                    Text("إجمالي الرصيد المتاح", style: TextStyle(color: Colors.black87, fontSize: 16)),
                    SizedBox(height: 10),
                    Text(
                      "$balance ريال يمني",
                      style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              
              // أزرار العمليات السريعة
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _walletAction(Icons.add_card, "إيداع"),
                  _walletAction(Icons.outbound, "سحب"),
                  _walletAction(Icons.history, "السجل"),
                ],
              ),
              
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("آخر العمليات", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              
              // قائمة العمليات (سنربطها بجدول transactions لاحقاً)
              Expanded(
                child: Center(
                  child: Text("لا توجد عمليات مالية حالياً", style: TextStyle(color: Colors.grey)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _walletAction(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Color(0xFF1A1A1A),
          radius: 30,
          child: Icon(icon, color: Colors.amber),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
