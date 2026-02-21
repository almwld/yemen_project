import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String title;
  final String price;
  final String image;

  ProductDetailsScreen({required this.title, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(image, fit: BoxFit.cover),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                          child: Text("موثق", style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(price, style: TextStyle(color: Colors.amber, fontSize: 22, fontWeight: FontWeight.bold)),
                    Divider(color: Colors.white24, height: 30),
                    
                    Text("المواصفات والتفاصيل:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    _detailRow(Icons.location_on, "الموقع", "صنعاء - شارع حدة"),
                    _detailRow(Icons.calendar_today, "تاريخ النشر", "منذ ساعتين"),
                    _detailRow(Icons.info_outline, "الحالة", "مستخدم نظيف جداً"),
                    
                    SizedBox(height: 20),
                    Text("وصف الإعلان:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("هذا المنتج متوفر للمعاينة المباشرة، السعر قابل للتفاوض البسيط بالمعقول. يرجى التواصل عبر الشات أو طلب الوساطة لضمان حقك.", 
                      style: TextStyle(color: Colors.white70, height: 1.5)),
                    
                    SizedBox(height: 40),
                    _buildEscrowCard(context),
                    SizedBox(height: 100), // مساحة للأسفل
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomSheet: _buildBottomAction(context),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.amber),
          SizedBox(width: 10),
          Text("$label: ", style: TextStyle(color: Colors.grey)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildEscrowCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.shield, color: Colors.blue),
              SizedBox(width: 10),
              Text("حماية فلكس يمن (الوساطة)", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10),
          Text("عند طلب الوساطة، سنقوم بحجز المبلغ في حساب المنصة حتى تستلم السلعة وتؤكد مطابقتها للمواصفات.", style: TextStyle(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("طلب شراء عبر الوسيط", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: Size(0, 50)),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: Colors.amber),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
