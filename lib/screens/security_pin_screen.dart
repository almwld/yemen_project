import 'package:flutter/material.dart';

class SecurityPinScreen extends StatefulWidget {
  final Widget nextScreen;
  SecurityPinScreen({required this.nextScreen});

  @override
  _SecurityPinScreenState createState() => _SecurityPinScreenState();
}

class _SecurityPinScreenState extends State<SecurityPinScreen> {
  String _pin = "";

  void _onKeyTap(String val) {
    if (_pin.length < 4) {
      setState(() => _pin += val);
      if (_pin.length == 4) {
        _verifyPin();
      }
    }
  }

  void _verifyPin() {
    if (_pin == "1234") { // الرمز الافتراضي للتجربة حالياً
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.nextScreen));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("الرمز غير صحيح!"), backgroundColor: Colors.red));
      setState(() => _pin = "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, color: Colors.amber, size: 80),
          SizedBox(height: 20),
          Text("أدخل رمز PIN للأمان", style: TextStyle(color: Colors.white, fontSize: 20)),
          SizedBox(height: 30),
          // دوائر عرض الرمز
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) => Container(
              margin: EdgeInsets.all(10),
              width: 20, height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index < _pin.length ? Colors.amber : Colors.grey[800],
              ),
            )),
          ),
          SizedBox(height: 50),
          // لوحة الأرقام
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 60),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 20, crossAxisSpacing: 20),
            itemCount: 12,
            itemBuilder: (context, index) {
              if (index == 9) return SizedBox(); // فارغ
              if (index == 10) return _buildKey("0");
              if (index == 11) return IconButton(onPressed: () => setState(() => _pin = ""), icon: Icon(Icons.backspace, color: Colors.grey));
              return _buildKey("${index + 1}");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String text) {
    return InkWell(
      onTap: () => _onKeyTap(text),
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.amber.withOpacity(0.2))),
        child: Center(child: Text(text, style: TextStyle(color: Colors.white, fontSize: 25))),
      ),
    );
  }
}
