import 'verification_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("الملف الشخصي", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.logout, color: gold), onPressed: () async {
            await Supabase.instance.client.auth.signOut();
            Navigator.pushReplacementNamed(context, '/login');
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // قسم الصورة والهوية
            _buildHeader(user, gold),
            const SizedBox(height: 30),
            // كرت المعلومات السريع (مثل الصورة التي أرفقتها)
            _buildQuickInfoCard(user?.id ?? "ID", gold),
            const SizedBox(height: 20),
            // قائمة الخيارات الملكية
            _buildProfileOption("توثيق حسابي الملكي", Icons.verified_user_outlined, gold, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VerificationRequestScreen()))),
            _buildProfileOption("تحديث بياناتي", Icons.cloud_upload_outlined, gold),
            _buildProfileOption("إدارة الأجهزة", Icons.phonelink_setup, gold),
            _buildProfileOption("الخصوصية والأمان", Icons.security_outlined, gold),
            _buildProfileOption("الدعم والمساعدة", Icons.headset_mic_outlined, gold),
            const SizedBox(height: 40),
            Text("إصدار فلكس يمن 1.0.0 VIP", style: TextStyle(color: gold.withOpacity(0.3), fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(User? user, Color gold) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: gold, width: 2)),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[900],
            child: Icon(Icons.person, size: 50, color: gold),
          ),
        ),
        const SizedBox(height: 10),
        Text("صباح الخير", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(user?.email?.split('@')[0] ?? "عضو فلكس", style: TextStyle(color: gold, fontSize: 14)),
      ],
    );
  }

  Widget _buildQuickInfoCard(String id, Color gold) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gold.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("رقم الحساب المميز", style: TextStyle(color: Colors.white54, fontSize: 12)),
              Text(id.substring(0, 8).toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: QrImageView(data: id, size: 50, version: QrVersions.auto),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(String title, IconData icon, Color gold) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: gold),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
        trailing: Icon(Icons.arrow_forward_ios, color: gold.withOpacity(0.3), size: 16),
        onTap: () {},
      ),
    );
  }
}
