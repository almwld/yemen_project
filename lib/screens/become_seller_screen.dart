import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BecomeSellerScreen extends StatefulWidget {
  @override
  _BecomeSellerScreenState createState() => _BecomeSellerScreenState();
}

class _BecomeSellerScreenState extends State<BecomeSellerScreen> {
  bool _isLoading = false;
  final supabase = Supabase.instance.client;

  Future<void> _requestSellerRole() async {
    setState(() => _isLoading = true);
    try {
      final userId = supabase.auth.currentUser!.id;
      
      // تحديث دور المستخدم إلى 'seller'
      // ملاحظة: في النسخة الاحترافية، يفضل أن يكون هذا 'pending_seller' حتى يوافق الآدمين
      await supabase.from('profiles').update({'role': 'seller'}).eq('id', userId);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تهانينا! أصبحت الآن تاجراً في فلكس يمن ")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("خطأ: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ابدأ البيع في فلكس يمن"), backgroundColor: Colors.amber),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront, size: 100, color: Colors.amber),
            SizedBox(height: 20),
            Text(
              "هل ترغب في عرض سياراتك أو عقاراتك لآلاف المستخدمين؟",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "بتحويل حسابك إلى تاجر، ستتمكن من إدارة مخزونك، تتبع مبيعاتك، وسحب أرباحك بكل سهولة عبر نظام الضمان.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            Spacer(),
            _isLoading 
              ? CircularProgressIndicator() 
              : ElevatedButton(
                  onPressed: _requestSellerRole,
                  child: Center(child: Text("تفعيل وضع التاجر الآن")),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.all(15),
                    textStyle: TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
