import 'package:flutter/material.dart';
import '../logic/app_state.dart';

class AdminWalletPanel extends StatefulWidget {
  @override
  _AdminWalletPanelState createState() => _AdminWalletPanelState();
}

class _AdminWalletPanelState extends State<AdminWalletPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('طلبات شحن الرصيد (للأدمن)')),
      body: AppData.depositRequests.isEmpty 
        ? Center(child: Text('لا توجد طلبات معلقة'))
        : ListView.builder(
            itemCount: AppData.depositRequests.length,
            itemBuilder: (context, index) {
              final req = AppData.depositRequests[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('شحن ${req['amount']} ريال عبر ${req['wallet']}'),
                  subtitle: Text('رقم العملية: ${req['txId']}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        AppData.approveDeposit(req);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم تفعيل الرصيد للمستخدم')));
                    },
                    child: Text('موافقة'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  ),
                ),
              );
            },
          ),
    );
  }
}
