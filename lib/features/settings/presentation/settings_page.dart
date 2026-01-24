import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: SwitchListTile(
        title: const Text('الوضع الليلي'),
        value: theme.mode == ThemeMode.dark,
        onChanged: (_) => theme.toggle(),
      ),
    );
  }
}
