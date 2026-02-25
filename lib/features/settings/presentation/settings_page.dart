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
        title: const Text('الوضع الداكن'),
        value: theme.themeMode == ThemeMode.dark,
        onChanged: theme.toggleTheme,
      ),
    );
  }
}
