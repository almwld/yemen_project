import 'package:flutter/material.dart';

class OrderStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('حالة الطلب'), backgroundColor: Colors.white10),
      body: Stepper(
        currentStep: 1,
        steps: [
          Step(title: Text('تم استلام الطلب'), content: Text('فريقنا يقوم بالتواصل مع التاجر الآن.'), isActive: true),
          Step(title: Text('قيد التجهيز'), content: Text('يتم فحص المنتج وتغليفه في مركزنا.'), isActive: true),
          Step(title: Text('جاري التوصيل'), content: Text('المندوب في طريقه إلى منزلك.'), isActive: false),
          Step(title: Text('تم التسليم'), content: Text('نتمنى أن ينال المنتج إعجابكم.'), isActive: false),
        ],
      ),
    );
  }
}
