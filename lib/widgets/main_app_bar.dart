import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const MainAppBar({super.key, required this.onThemeToggle, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFFB38728)), // الثلاث شرطات
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: ShaderMask(
        shaderCallback: (bounds) => FlexTheme.goldenGradient.createShader(bounds),
        child: const Text(
          "FLEX YEMEN",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: const Color(0xFFB38728)),
          onPressed: onThemeToggle,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
