import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final bool isMerchant = true; // يتم جلبها من قاعدة البيانات لاحقاً

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildWalletCard(),
            _buildActionList(context),
            if (isMerchant) _buildMerchantTools(),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.amber, Colors.orangeAccent]),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: Colors.amber),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bin Obaeid", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                child: Text(isMerchant ? "حساب تاجر موثق ✅" : "حساب عميل", style: TextStyle(color: Colors.amber, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCard() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.amber.withOpacity(0.3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("رصيد محفظة فلكس", style: TextStyle(color: Colors.grey)),
              Text("150,000 ر.ي", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            child: Text("شحن", style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }

  Widget _buildActionList(BuildContext context) {
    return Column(
      children: [
        _profileTile(Icons.history, "سجل العمليات والطلبات"),
        _profileTile(Icons.favorite_border, "المفضلة"),
        _profileTile(Icons.location_on_outlined, "عناويني"),
        _profileTile(Icons.security, "مركز الأمان والخصوصية"),
      ],
    );
  }

  Widget _buildMerchantTools() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text("أدوات التاجر 💼", style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        _profileTile(Icons.add_business, "إضافة إعلان جديد (سيارة، عقار...)"),
        _profileTile(Icons.analytics_outlined, "إحصائيات المبيعات"),
        _profileTile(Icons.support_agent, "تواصل مع الإدارة"),
      ],
    );
  }

  Widget _profileTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: TextButton(
        onPressed: () {},
        child: Text("تسجيل الخروج", style: TextStyle(color: Colors.redAccent, fontSize: 16)),
      ),
    );
  }
}
