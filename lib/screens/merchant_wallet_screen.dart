import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MerchantWalletScreen extends StatefulWidget {
  const MerchantWalletScreen({super.key});

  @override
  State<MerchantWalletScreen> createState() => _MerchantWalletScreenState();
}

class _MerchantWalletScreenState extends State<MerchantWalletScreen> {
  final _supabase = Supabase.instance.client;
  double _balance = 0.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBalance();
  }

  Future<void> _fetchBalance() async {
    final user = _supabase.auth.currentUser;
    final data = await _supabase.from('wallets').select('balance').eq('user_id', user!.id).single();
    setState(() => _balance = (data['balance'] as num).toDouble());
  }

  void _requestWithdrawal() {
    // سنفتح نافذة منبثقة لطلب السحب هنا
    _showWithdrawDialog();
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("محفظتي الذهبية", style: TextStyle(color: gold)), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildBalanceCard(gold),
            const SizedBox(height: 30),
            _buildActionButtons(gold),
            const Expanded(child: SizedBox()),
            const Text("جميع العمليات موثقة ومؤمنة من فلكس يمن", style: TextStyle(color: Colors.white24, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(Color gold) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [gold, const Color(0xFFB8860B)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: gold.withOpacity(0.3), blurRadius: 20)],
      ),
      child: Column(
        children: [
          const Text("الرصيد القابل للسحب", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text("${_balance.toStringAsFixed(2)} ريال", style: const TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Color gold) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white10,
        minimumSize: const Size(double.infinity, 55),
        side: BorderSide(color: gold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: _requestWithdrawal,
      icon: Icon(Icons.account_balance_wallet, color: gold),
      label: Text("طلب سحب الأرباح الآن", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
    );
  }

  void _showWithdrawDialog() {
    // نافذة اختيار طريقة السحب (كريمي، نجم)
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Container(padding: const EdgeInsets.all(25), child: const Text("سيتم إضافة نموذج السحب في التحديث القادم")),
    );
  }
}
