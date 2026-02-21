import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  bool isCodeSent = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("التحقق من الهوية"), elevation: 0),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isCodeSent ? Icons.mark_email_read : Icons.phone_android, size: 80, color: Colors.amber),
            SizedBox(height: 30),
            Text(
              isCodeSent ? "أدخل رمز التحقق المرسل لهاتفك" : "سجل برقم هاتفك اليمني للبدء",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            
            if (!isCodeSent)
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "777 000 000",
                  prefixText: "+967 ",
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              )
            else
              TextField(
                controller: codeController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(letterSpacing: 10, fontSize: 24),
                decoration: InputDecoration(
                  hintText: "0 0 0 0",
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (!isCodeSent) {
                  setState(() => isCodeSent = true);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم إرسال الرمز إلى ${phoneController.text}")));
                } else {
                  Navigator.pop(context); // العودة بعد النجاح
                }
              },
              child: Text(isCodeSent ? "تأكيد الرمز" : "إرسال رمز التحقق", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
