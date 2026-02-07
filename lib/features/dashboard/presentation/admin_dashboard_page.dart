import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 4;

  void _openAddAdSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(child: Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
            SizedBox(height: 20),
            Text("إضافة إعلان جديد", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(textAlign: TextAlign.right, decoration: InputDecoration(labelText: "عنوان الإعلان", border: OutlineInputBorder())),
            SizedBox(height: 15),
            TextField(textAlign: TextAlign.right, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "السعر (ريال يمني)", border: OutlineInputBorder())),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Icon(Icons.arrow_drop_down), Text("اختر القسم")],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(color: Colors.orange[50], border: Border.all(color: Colors.orange), borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add_a_photo, size: 40, color: Colors.orange), Text("أضف صور المنتج")],
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[800], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                child: Text("نشر الإعلان الآن", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.notifications_none, color: Colors.black),
        title: Text("فليكس يمن ماركت", style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(child: Text("تم استعادة التصميم المشرق\nاضغط على زر أضف إعلان بالأسفل", textAlign: TextAlign.center)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange[800],
        onTap: (index) {
          if (index == 2) {
            _openAddAdSheet();
          } else {
            setState(() => _selectedIndex = index);
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "المفضلة"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40), label: "أضف"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "استكشف"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
        ],
      ),
    );
  }
}
