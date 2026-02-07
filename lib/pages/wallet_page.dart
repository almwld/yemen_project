import 'package:flutter/material.dart';
import '../logic/app_state.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String selectedWallet = AppData.yemeniWallets[0];
  final amountController = TextEditingController();
  final txController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('المحفظة وإثبات الشحن')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity, padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.green[700], borderRadius: BorderRadius.circular(15)),
              child: Center(child: Text('رصيدك الحالي: ${AppData.userBalance} ريال', style: TextStyle(color: Colors.white, fontSize: 22))),
            ),
            SizedBox(height: 20),
            Text('قم بالتحويل أولاً عبر ${selectedWallet} ثم ارفع البيانات', style: TextStyle(fontSize: 12, color: Colors.red)),
            DropdownButton<String>(
              isExpanded: true, value: selectedWallet,
              items: AppData.yemeniWallets.map((w) => DropdownMenuItem(value: w, child: Text(w))).toList(),
              onChanged: (val) => setState(() => selectedWallet = val!),
            ),
            TextField(controller: amountController, decoration: InputDecoration(labelText: 'المبلغ المحول'), keyboardType: TextInputType.number),
            TextField(controller: txController, decoration: InputDecoration(labelText: 'رقم العملية (Reference ID)')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(amountController.text.isNotEmpty && txController.text.isNotEmpty) {
                  AppData.requestDeposit(selectedWallet, double.parse(amountController.text), txController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم إرسال طلب الشحن للأدمن للمراجعة')));
                  amountController.clear(); txController.clear();
                }
              },
              child: Text('إرسال إثبات التحويل'),
            )
          ],
        ),
      ),
    );
  }
}
