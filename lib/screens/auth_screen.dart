import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isSignUp = false;

  Future<void> _handleAuth() async {
    setState(() => _isLoading = true);
    try {
      if (_isSignUp) {
        await Supabase.instance.client.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم إنشاء الحساب! يرجى تأكيد البريد")));
      } else {
        await Supabase.instance.client.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("خطأ: ${e.toString()}")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Flex Yemen", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'البريد الإلكتروني', filled: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'كلمة المرور', filled: true),
            ),
            const SizedBox(height: 24),
            _isLoading 
              ? const CircularProgressIndicator() 
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 50)),
                  onPressed: _handleAuth,
                  child: Text(_isSignUp ? "إنشاء حساب" : "تسجيل الدخول", style: const TextStyle(color: Colors.black)),
                ),
            TextButton(
              onPressed: () => setState(() => _isSignUp = !_isSignUp),
              child: Text(_isSignUp ? "لديك حساب بالفعل؟ سجل دخولك" : "ليس لديك حساب؟ اشترك الآن"),
            )
          ],
        ),
      ),
    );
  }
}
