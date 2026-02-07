import 'package:flutter/material.dart';
import '../logic/app_state.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تقارير الإدارة والأرباح'), backgroundColor: Colors.indigo),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // قسم الإحصائيات السريعة
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.indigo[50],
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
                children: [
                  _statCard("إجمالي المبيعات", "${AppData.totalSales} ريال", Colors.green),
                  _statCard("طلبات مكتملة", "${AppData.successfulOrdersCount}", Colors.blue),
                  _statCard("شحنات معلقة", "${AppData.depositRequests.length}", Colors.orange),
                  _statCard("سيولة معلقة", "${AppData.pendingDepositsTotal} ريال", Colors.red),
                ],
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("طلبات الشحن الجديدة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Divider(),
                  AppData.depositRequests.isEmpty 
                    ? Text("لا توجد حوالات بانتظار التأكيد")
                    : Column(
                        children: AppData.depositRequests.map((req) => ListTile(
                          title: Text('حوالة: ${req['amount']} ريال'),
                          subtitle: Text('عبر: ${req['wallet']}'),
                          trailing: IconButton(
                            icon: Icon(Icons.check_circle, color: Colors.green),
                            onPressed: () { AppData.approveDeposit(req); (context as Element).markNeedsBuild(); },
                          ),
                        )).toList(),
                      ),
                  SizedBox(height: 20),
                  Text("سجل المبيعات الأخير", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Divider(),
                  ...AppData.orders.map((order) => ListTile(
                    leading: Icon(Icons.receipt_long),
                    title: Text('طلب بقيمة ${order['total']} ريال'),
                    subtitle: Text('الحالة: ${order['status']}'),
                  )).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, Color color) {
    return Card(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 12)),
            Text(value, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
