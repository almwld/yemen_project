import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WithdrawScreen extends StatefulWidget {
  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountController = TextEditingController();
  final _addressController = TextEditingController(); // رقم الحساب أو الاسم
  String _selectedMethod = 'الكريمي';
  bool _isLoading = false;
  final supabase = Supabase.instance.client;

  Future<void> _submitWithdraw() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0 || _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("يرجى إدخال مبلغ صحيح وبيانات الاستلام")));
      return;
    }

    setState(() => _isLoading = true);
    try {
      final userId = supabase.auth.currentUser!.id;
      
      // تسجيل طلب السحب في قاعدة البيانات
      await supabase.from('withdraw_requests').insert({
        'user_id': userId,
        'amount': amount,
        'method': _selectedMethod,
        'transfer_details': _addressController.text,
        'status': 'pending'
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم إرسال طلب السحب، سيتم التواصل معك بعد التنفيذ")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل الطلب: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("سحب الأرباح"), backgroundColor: Colors.orangeAccent),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "المبلغ المراد سحبه", prefixIcon: Icon(Icons.account_balance_wallet)),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _selectedMethod,
              items: ['الكريمي', 'النجم', 'أم فلوس', 'جوالي'].map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
              onChanged: (val) => setState(() => _selectedMethod = val!),
              decoration: InputDecoration(labelText: "وسيلة الاستلام"),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: "رقم الحساب أو الاسم الكامل للمستلم", hintText: "مثلاً: 1234567"),
            ),
            Spacer(),
            _isLoading 
              ? CircularProgressIndicator() 
              : ElevatedButton(
                  onPressed: _submitWithdraw,
                  child: Center(child: Text("تأكيد طلب السحب")),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: EdgeInsets.all(15)),
                ),
          ],
        ),
      ),
    );
  }
}
