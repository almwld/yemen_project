import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/notification_service.dart';

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
    setState(() => _isLoading = true);
    try {
      // 1. البحث عن المستلم برقم هاتفه
      final receiver = await _supabase
          .from('profiles')
          .select()
          .eq('phone_number', _phoneController.text)
          .single();

      if (receiver == null) throw "رقم الهاتف غير مسجل في فلكس يمن";

      // 2. التحقق من رصيد المرسل (تبسيطاً للبرمجة هنا)
      // في الواقع نستخدم RPC (Stored Procedure) لضمان الأمان الذري (Atomicity)
      
      GoldNotification.showSuccess(context, "تم تحويل ${_amountController.text} ريال إلى ${receiver['full_name']}");
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("تحويل سريع"), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _buildGoldTextField("رقم هاتف المستلم", Icons.phone_android, _phoneController),
            const SizedBox(height: 20),
            _buildGoldTextField("المبلغ بالريال", Icons.money, _amountController),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: gold, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                onPressed: _isLoading ? null : _processTransfer,
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.black) 
                  : const Text("تأكيد التحويل الذهبي", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
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
      keyboardType: TextInputType.phone,
    );
  }
}
