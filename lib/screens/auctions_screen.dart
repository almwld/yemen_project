import 'package:flutter/material.dart';
import 'dart:async';

class AuctionsScreen extends StatefulWidget {
  @override
  _AuctionsScreenState createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends State<AuctionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("مزادات فلكس يمن"), centerTitle: true),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildAuctionCard(
            "سيارة تويوتا بازرعة 2024", 
            "25,000 \$", 
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
      decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
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
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(Icons.timer, size: 14, color: Colors.white),
                      SizedBox(width: 5),
                      Text(timeLeft, style: TextStyle(fontWeight: FontWeight.bold)),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("أعلى سومة: $currentBid", style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("زايد الآن", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
