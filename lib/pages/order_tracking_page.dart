import 'package:flutter/material.dart';
import '../logic/app_state.dart';

class OrderTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تتبع مباشر للطلب')),
      body: AppData.orders.isEmpty
          ? Center(child: Text('لا توجد طلبات جارية حالياً'))
          : Column(
              children: [
                // جزء الخريطة (محاكاة بصرية)
                Container(
                  height: 300,
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue[100]!),
                  ),
                  child: Stack(
                    children: [
                      Center(child: Icon(Icons.map, size: 100, color: Colors.blue[100])),
                      // أيقونة المنزل
                      Positioned(top: 40, left: 40, child: Icon(Icons.home, color: Colors.red, size: 40)),
                      // أيقونة الموصل (محاكاة الحركة)
                      Positioned(bottom: 60, right: 80, child: Column(
                        children: [
                          Icon(Icons.delivery_dining, color: Colors.blue, size: 40),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: Text('الموصل قادم', style: TextStyle(fontSize: 10)),
                          )
                        ],
                      )),
                      // رسم مسار منقط (محاكاة)
                      Center(child: Text('.......................', style: TextStyle(color: Colors.blue.withOpacity(0.3)))),
                    ],
                  ),
                ),
                // تفاصيل الطلب تحت الخريطة
                Expanded(
                  child: ListView.builder(
                    itemCount: AppData.orders.length,
                    itemBuilder: (context, index) {
                      final order = AppData.orders[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.local_shipping, color: Colors.white)),
                          title: Text('الحالة: ${order['status']}'),
                          subtitle: Text('تاريخ الطلب: ${order['date'].toString().substring(0, 16)}'),
                          trailing: Text('${order['total']} ريال', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
