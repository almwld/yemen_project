import 'package:flutter/material.dart';
import 'dart:async';

class AuctionItem extends StatefulWidget {
  final String name;
  final double startPrice;
  
  AuctionItem({required this.name, required this.startPrice});

  @override
  _AuctionItemState createState() => _AuctionItemState();
}

class _AuctionItemState extends State<AuctionItem> {
  late double currentBid;
  int bidsCount = 5;

  @override
  void initState() {
    currentBid = widget.startPrice;
    super.initState();
  }

  void _makeBid() {
    setState(() {
      currentBid += 100.0; // زيادة 100 دولار في كل ضغطة
      bidsCount++;
    });
    // إظهار تنبيه سريع (SnackBar)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("تم تسجيل مزايدتك بنجاح! السعر الحالي: $currentBid$"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.redAccent),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("عدد المزايدات: $bidsCount", style: TextStyle(color: Colors.grey)),
          ),
          Text("$currentBid$", style: TextStyle(color: Colors.amber, fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: _makeBid,
            child: Text("زايد الآن +100$", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
