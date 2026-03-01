import 'package:flutter/material.dart';

class BillPaymentScreen extends StatefulWidget {
  const BillPaymentScreen({super.key});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  final Color gold = const Color(0xFFD4AF37);
  final _accountController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedService = 'إنترنت (ADSL)';

  final List<Map<String, dynamic>> _services = [
    {'name': 'إنترنت (ADSL)', 'icon': Icons.language},
    {'name': 'كهرباء (عمومي)', 'icon': Icons.electric_bolt},
    {'name': 'مياه (حكومي)', 'icon': Icons.water_drop},
    {'name': 'هاتف ثابت', 'icon': Icons.phone_callback},
    {'name': 'شحن يو (You)', 'icon': Icons.cell_tower},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("تسديد الفواتير", style: TextStyle(color: gold)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("اختر نوع الخدمة", style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 15),
            _buildServiceSelector(),
            const SizedBox(height: 30),
            _buildInputField("رقم الحساب / الهاتف", _accountController, Icons.numbers, gold),
            const SizedBox(height: 20),
            _buildInputField("المبلغ (بالريال اليمني)", _amountController, Icons.money, gold),
            const SizedBox(height: 40),
            _buildPayButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceSelector() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _services.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedService == _services[index]['name'];
          return GestureDetector(
            onTap: () => setState(() => _selectedService = _services[index]['name']),
            child: Container(
              width: 100,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSelected ? gold : Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: gold.withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_services[index]['icon'], color: isSelected ? Colors.black : gold),
                  const SizedBox(height: 5),
                  Text(_services[index]['name'], 
                    textAlign: TextAlign.center,
                    style: TextStyle(color: isSelected ? Colors.black : Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, IconData icon, Color gold) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: gold.withOpacity(0.7)),
        prefixIcon: Icon(icon, color: gold),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: gold.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: gold)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
      ),
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: gold,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () {
          // هنا يتم الربط مع API التسديد وخصم الرصيد
          _showConfirmation();
        },
        child: const Text("تأكيد التسديد والخصم من المحفظة", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  void _showConfirmation() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, color: gold, size: 60),
            const SizedBox(height: 20),
            const Text("تأكيد العملية", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("هل أنت متأكد من خصم مبلغ ${_amountController.text} ريال لتسديد $_selectedService؟", 
              textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء"))),
                const SizedBox(width: 10),
                Expanded(child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: gold),
                  onPressed: () => Navigator.pop(context), 
                  child: const Text("تأكيد", style: TextStyle(color: Colors.black)))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
