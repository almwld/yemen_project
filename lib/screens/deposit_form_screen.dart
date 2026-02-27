import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DepositFormScreen extends StatefulWidget {
  final String methodName;
  const DepositFormScreen({super.key, required this.methodName});

  @override
  State<DepositFormScreen> createState() => _DepositFormScreenState();
}

class _DepositFormScreenState extends State<DepositFormScreen> {
  final _amountController = TextEditingController();
  final _refController = TextEditingController();
  bool _isSaving = false;

  void _submitDeposit() async {
    setState(() => _isSaving = true);
    final user = Supabase.instance.client.auth.currentUser;
    
    await Supabase.instance.client.from('wallet_transactions').insert({
      'user_id': user?.id,
      'amount': double.parse(_amountController.text),
      'method': widget.methodName,
      'reference_number': _refController.text,
      'status': 'pending',
    });

    setState(() => _isSaving = false);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم إرسال طلب الشحن، سيتم التأكد من العملية خلال دقائق")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("شحن عبر ${widget.methodName}")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("أرسل المبلغ إلى حسابنا في ${widget.methodName} ثم أدخل البيانات أدناه:"),
            const SizedBox(height: 20),
            TextField(controller: _amountController, decoration: const InputDecoration(labelText: "المبلغ بالريال")),
            const SizedBox(height: 15),
            TextField(controller: _refController, decoration: const InputDecoration(labelText: "رقم الحوالة / العملية")),
            const SizedBox(height: 30),
            _isSaving 
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 50)),
                  onPressed: _submitDeposit, 
                  child: const Text("تأكيد إرسال الطلب", style: TextStyle(color: Colors.black))
                ),
          ],
        ),
      ),
    );
  }
}
