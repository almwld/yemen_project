import 'package:flutter/material.dart';
import '../logic/state_engine.dart';

class GrandPortalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("دولة فلكس الرقمية 🛡️", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 10,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 1.1,
        ),
        itemCount: StateEngine.digitalState.keys.length,
        itemBuilder: (context, index) {
          String sector = StateEngine.digitalState.keys.elementAt(index);
          return _buildSectorCard(sector, context);
        },
      ),
    );
  }

  Widget _buildSectorCard(String title, BuildContext context) {
    return InkWell(
      onTap: () {
        // فتح المنظومة الفرعية
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.grey[900]!, Colors.black]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance, color: Colors.amber, size: 40),
            SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text("${StateEngine.digitalState[title]!.length} خدمة", style: TextStyle(color: Colors.grey, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
