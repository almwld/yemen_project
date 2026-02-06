import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/wallet_cubit.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المحفظة')),
      body: Center(
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.account_balance_wallet, size: 80),
                const SizedBox(height: 20),
                Text(
                  '${state.balance.toStringAsFixed(2)} \$',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      context.read<WalletCubit>().deposit(50),
                  child: const Text('شحن +50\$'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
