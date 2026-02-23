import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'chat_screen.dart';

class DriverChatView extends StatelessWidget {
  final String orderId;
  final String buyerName;
  final String driverName;

  DriverChatView({required this.orderId, required this.buyerName, required this.driverName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("دردشة التوصيل", style: TextStyle(fontSize: 16)),
            Text("الطلب: #${orderId.substring(0,8)}", style: TextStyle(fontSize: 12, color: Colors.grey[400])),
          ],
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ChatScreen(
        orderId: orderId, 
        receiverName: buyerName, // هنا المندوب يراسل المشتري
      ),
    );
  }
}
