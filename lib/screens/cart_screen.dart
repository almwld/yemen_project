import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Color gold = const Color(0xFFD4AF37);
  
  // بيانات تجريبية للسلة (يمكن ربطها لاحقاً بقاعدة البيانات المحلية)
  List<Map<String, dynamic>> cartItems = [
    {"name": "آيفون 15 برو", "price": 450000, "qty": 1},
    {"name": "سماعة بلوتوث", "price": 25000, "qty": 2},
  ];

  double calculateTotal() {
    return cartItems.fold(0, (sum, item) => sum + (item['price'] * item['qty']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("سلة المشتريات", style: TextStyle(color: gold)),
        centerTitle: true,
      ),
      body: cartItems.isEmpty 
        ? Center(child: Text("السلة فارغة", style: TextStyle(color: Colors.grey)))
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      color: Colors.white10,
                      child: ListTile(
                        leading: CircleAvatar(backgroundColor: gold, child: Icon(Icons.shopping_bag, color: Colors.black)),
                        title: Text(item['name'], style: TextStyle(color: Colors.white)),
                        subtitle: Text("${item['price']} ريال x ${item['qty']}", style: TextStyle(color: gold)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(icon: Icon(Icons.remove_circle_outline, color: Colors.red), onPressed: () {
                              setState(() { if(item['qty'] > 1) item['qty']--; });
                            }),
                            IconButton(icon: Icon(Icons.delete_outline, color: Colors.grey), onPressed: () {
                              setState(() { cartItems.removeAt(index); });
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // ملخص الفاتورة وزر الدفع
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("الإجمالي:", style: TextStyle(fontSize: 18, color: Colors.white)),
                        Text("${calculateTotal()} ريال", style: TextStyle(fontSize: 22, color: gold, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () => _showPaymentDialog(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gold,
                        foregroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("إتمام الدفع من المحفظة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A1A1A),
        title: Text("تأكيد الدفع", style: TextStyle(color: gold), textAlign: TextAlign.right),
        content: Text("هل تريد خصم مبلغ ${calculateTotal()} ريال من محفظتك في فلكس؟", textAlign: TextAlign.right, style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("إلغاء", style: TextStyle(color: Colors.grey))),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("تأكيد"), style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black)),
        ],
      ),
    );
  }
}
