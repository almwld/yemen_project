import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/receipt_service.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _supabase = Supabase.instance.client;
  bool _isLoading = false;

  Future<void> _processTransfer() async {
    if (_amountController.text.isEmpty || _phoneController.text.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final double amount = double.parse(_amountController.text);
      final String phone = _phoneController.text;

      // 1. استدعاء وظيفة سوبابيس الذكية التي أصلحناها (RPC)
      await _supabase.rpc('transfer_funds_with_commission', params: {
        'p_sender_id': _supabase.auth.currentUser!.id,
        'p_receiver_phone': phone,
        'p_amount': amount,
      });

      // 2. جلب اسم المستلم لإظهاره في الإيصال
      final receiverData = await _supabase
          .from('profiles')
          .select('full_name, commission_rate')
          .eq('phone_number', phone)
          .single();

      final String receiverName = receiverData['full_name'] ?? "عميل فلكس";
      final double rate = (receiverData['commission_rate'] ?? 0.01).toDouble();
      
      // 3. حساب الحسبة للإيصال
      final double fee = amount * rate;
      final double total = amount; // المبلغ المخصوم من المرسل

      if (!mounted) return;

      // 4. إظهار الإيصال الذهبي الفخم
      ReceiptService.showGoldReceipt(
        context,
        receiverName: receiverName,
        amount: (amount - fee).toStringAsFixed(2), // الصافي للمستلم
        fee: fee.toStringAsFixed(2),
        total: total.toStringAsFixed(2),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ: ${e.toString()}"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("تحويل ذهبي سريع", style: TextStyle(color: Color(0xFFD4AF37))),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: gold),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Icon(Icons.send_to_mobile, color: Color(0xFFD4AF37), size: 80),
            const SizedBox(height: 30),
            _buildGoldTextField("رقم هاتف المستلم", Icons.phone_android, _phoneController),
            const SizedBox(height: 20),
            _buildGoldTextField("المبلغ المراد تحويله", Icons.account_balance_wallet, _amountController),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: _isLoading ? null : _processTransfer,
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.black) 
                  : const Text("إرسال الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoldTextField(String label, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFFD4AF37)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white10), borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFD4AF37)), borderRadius: BorderRadius.circular(15)),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
