import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text("حسابي الشخصي", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF00ACC1), Color(0xFF00796B)]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // قسم رأس الصفحة (معلومات المستخدم)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF00796B),
                    backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                    child: user?.photoURL == null ? Icon(Icons.person, size: 50, color: Colors.white) : null,
                  ),
                  SizedBox(height: 15),
                  Text(
                    user?.displayName ?? (user!.isAnonymous ? "زائر (ضيف)" : "مستخدم يمن ماركت"),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(user?.email ?? "لا يوجد بريد مرتبط", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            
            SizedBox(height: 20),

            // قائمة الخيارات
            buildProfileOption(Icons.shopping_bag_outlined, "طلباتي", () {}),
            buildProfileOption(Icons.favorite_border, "المفضلة", () {}),
            buildProfileOption(Icons.location_on_outlined, "عنوان التوصيل", () {}),
            buildProfileOption(Icons.help_outline, "مركز المساعدة", () {}),
            
            SizedBox(height: 30),

            // زر تسجيل الخروج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: Icon(Icons.logout),
                label: Text("تسجيل الخروج"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF00796B)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
