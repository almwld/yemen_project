import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المحفظة')),
      body: Center(
        child: Text(
          'الرصيد: 250 \$',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
