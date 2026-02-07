import 'package:flutter/material.dart';
import '../logic/app_state.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('سلة المشتريات')),
      body: Column(
        children: [
          Expanded(
            child: AppData.cart.isEmpty 
              ? Center(child: Text('السلة فارغة'))
              : ListView.builder(
                  itemCount: AppData.cart.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(AppData.cart[index]['title']),
                    trailing: Text('${AppData.cart[index]['price']} ريال'),
                  ),
                ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: Column(
              children: [
                // حقل الكوبون
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: promoController,
                        decoration: InputDecoration(hintText: 'أدخل كود الخصم', border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (AppData.applyPromoCode(promoController.text)) {
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم تطبيق الخصم بنجاح!')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('كود غير صالح')));
                        }
                      },
                      child: Text('تطبيق'),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('الإجمالي بعد الخصم:'),
                  Text('${AppData.cartTotal.toStringAsFixed(2)} ريال', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                ]),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.blue),
                  onPressed: () {
                    if (AppData.processPayment()) {
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تمت عملية الشراء!')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل الدفع، تأكد من رصيدك')));
                    }
                  },
                  child: Text('دفع من المحفظة', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
