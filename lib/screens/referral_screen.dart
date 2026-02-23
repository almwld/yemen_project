import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ReferralScreen extends StatelessWidget {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    
    return Scaffold(
      appBar: AppBar(title: Text("شارك واربح 💰"), backgroundColor: Colors.indigo),
      body: FutureBuilder(
        future: supabase.from('profiles').select('referral_code').eq('id', user!.id).single(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final code = snapshot.data!['referral_code'];

          return Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.card_giftcard, size: 100, color: Colors.indigo),
                SizedBox(height: 20),
                Text("ادعُ أصدقاءك للحصول على رصيد مجاني!", 
                  textAlign: TextAlign.center, 
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("عندما يشحن صديقك رصيده لأول مرة، ستحصل أنت على مكافأة 500 ر.ي", 
                  textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.indigo)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(code, style: TextStyle(fontSize: 24, letterSpacing: 5, fontWeight: FontWeight.bold, color: Colors.amber)),
                      IconButton(
                        icon: Icon(Icons.copy, color: Colors.white),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: code));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم نسخ الكود")));
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Share.share("حمل تطبيق فلكس يمن واستخدم كود الإحالة الخاص بي ($code) لتحصل على مميزات خاصة! 🇾🇪");
                  },
                  icon: Icon(Icons.share),
                  label: Text("ارسل الرابط الآن"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, minimumSize: Size(double.infinity, 50)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
