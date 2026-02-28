import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _selectedPayment;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  // القائمة المحدثة بجميع المحافظ اليمنية والطرق العالمية
  final Map<String, String> _paymentAccounts = {
    'جيب (Jeeb)': '77XXXXXXX',
    'فلوسك (Kuraimi)': '12345678',
    'إيزي (PYS)': '77XXXXXXX',
    'بنكي لايت (YKB)': '77XXXXXXX',
    'جوالي (CAC)': '77XXXXXXX',
    'النجم (حوالة)': 'باسم: فلكس يمن للخدمات',
    'باينانس (USDT)': 'TRC20: TXXXXXXXXXXXXX',
  };

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("إنهاء الطلب"), 
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("بيانات التواصل", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "الاسم الكامل", 
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[800]!)),
              ),
            ),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "رقم الهاتف / الواتساب", 
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[800]!)),
              ),
            ),
            const SizedBox(height: 30),
            const Text("اختر وسيلة الدفع", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            // عرض قائمة المحافظ بشكل مرتب
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: _paymentAccounts.keys.map((method) => RadioListTile<String>(
                  title: Text(method, style: const TextStyle(color: Colors.white, fontSize: 15)),
                  value: method,
                  groupValue: _selectedPayment,
                  activeColor: const Color(0xFFD4AF37),
                  onChanged: (val) => setState(() => _selectedPayment = val),
                )).toList(),
              ),
            ),

            if (_selectedPayment != null) ...[
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withOpacity(0.1), 
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.5)),
                ),
                child: Column(
                  children: [
                    const Text("يرجى تحويل المبلغ إلى:", style: TextStyle(color: Colors.white70, fontSize: 13)),
                    const SizedBox(height: 5),
                    SelectableText(
                      _paymentAccounts[_selectedPayment]!, 
                      style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    const Text("(اضغط مطولاً للنسخ)", style: TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37), 
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                if (_nameController.text.isEmpty || _phoneController.text.isEmpty || _selectedPayment == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("يرجى إكمال جميع البيانات واختيار طريقة الدفع")),
                  );
                  return;
                }
                // سيتم هنا ربط الإرسال للواتساب في الخطوة القادمة
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("جاري تجهيز رسالة الطلب...")));
              },
              child: const Text("تأكيد الطلب عبر واتساب", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
