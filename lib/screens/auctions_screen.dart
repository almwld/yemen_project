import 'merchant_profile.dart';
import 'promote_ad_screen.dart';
import '../services/share_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AuctionsScreen extends StatefulWidget {
  @override
  _AuctionsScreenState createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends State<AuctionsScreen> {
  final Color goldColor = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("مزادات فلكس يمن", style: TextStyle(color: goldColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: goldColor),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildAuctionCard(
            "سيارة تويوتا بازرعة 2024",
            "25,000\$", // تم إصلاح علامة الدولار هنا
            "02:45:10",
            "https://picsum.photos/id/${index + 80}/400/250"
          );
        },
      ),
    );
  }

  Widget _buildAuctionCard(String title, String currentBid, String timeLeft, String img) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A), 
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: goldColor.withOpacity(0.2))
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(img, height: 180, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                top: 10, right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Icon(Icons.timer, size: 14, color: Colors.white),
                      SizedBox(width: 5),
                      Text(timeLeft, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("أعلى سومة: $currentBid", style: TextStyle(color: goldColor, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("جاري فتح غرفة المزايدة..."), backgroundColor: goldColor)
                    );
                  },
                  child: Text("زايد الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: goldColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
