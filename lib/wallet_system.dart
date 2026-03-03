import 'package:flutter/material.dart';

class WalletSystem extends StatefulWidget {
  @override
  _WalletSystemState createState() => _WalletSystemState();
}

class _WalletSystemState extends State<WalletSystem> {
  bool isEscrowActive = true; // محاكاة وجود عملية عربون قائمة

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // كرت الرصيد الفاخر
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)]),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 5))],
            ),
            child: Column(
              children: const [
                Text("إجمالي الرصيد (محفظة فلكس)", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("1,250,500 RY", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
                Text("≈ $2,084.00", style: TextStyle(color: Colors.black45, fontSize: 16)),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // قسم "عمليات العربون المعلقة"
          if (isEscrowActive)
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(5)),
                        child: const Text("عربون معلق", style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                      const Text("وساطة: فيلا حدة", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("المبلغ المحجوز: 500,000 RY", style: TextStyle(color: Color(0xFFD4AF37))),
                  const Divider(color: Colors.white10, height: 20),
                  const Text("بصفتك (بائع)، هل استلمت العربون يدوياً أو تم الاتفاق؟", 
                    textAlign: TextAlign.right, style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
                          onPressed: () {
                            setState(() => isEscrowActive = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("تم تأكيد الاستلام! تم فتح الموقع الدقيق للمشتري ✅"))
                            );
                          },
                          child: const Text("تأكيد الاستلام", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
                          child: const Text("إلغاء العملية", style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            
          const SizedBox(height: 20),
          _buildActionRow(Icons.add_circle_outline, "شحن المحفظة"),
          _buildActionRow(Icons.history, "سجل المعاملات المكتملة"),
          _buildActionRow(Icons.shield_outlined, "سياسة الوساطة والضمان"),
        ],
      ),
    );
  }

  Widget _buildActionRow(IconData icon, String title) => ListTile(
    leading: const Icon(Icons.arrow_back_ios, size: 14, color: Colors.grey),
    title: Text(title, textAlign: TextAlign.right),
    trailing: Icon(icon, color: const Color(0xFFD4AF37)),
  );
}
