import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Row(
          children: [
            Icon(Icons.support_agent, color: Colors.amber),
            SizedBox(width: 10),
            Text('مركز خدمة العملاء والطلبات'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              color: Colors.amber.withOpacity(0.1),
              child: ListTile(
                leading: Icon(Icons.info, color: Colors.amber),
                title: Text('نحن هنا لخدمتك', style: TextStyle(color: Colors.white, fontSize: 14)),
                subtitle: Text('أرسل استفسارك وسيقوم فريقنا بتجهيز طلبك وتوصيله إليك.', style: TextStyle(color: Colors.white54, fontSize: 12)),
              ),
            ),
          ),
          Expanded(child: Container()), // مساحة الرسائل
          _buildOrderInput(),
        ],
      ),
    );
  }

  Widget _buildOrderInput() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white10,
      child: Row(
        children: [
          Expanded(child: TextField(decoration: InputDecoration(hintText: 'اطلب منتجك الآن...', border: InputBorder.none))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {}, 
            child: Text('تأكيد الطلب'),
          ),
        ],
      ),
    );
  }
}
