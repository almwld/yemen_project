import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlexButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool isGold;

  FlexButton({required this.child, required this.onPressed, this.isGold = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => HapticFeedback.lightImpact(), // اهتزاز خفيف عند اللمس
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isGold ? Colors.amber : Colors.grey[900],
          foregroundColor: Colors.black,
          elevation: 8,
          shadowColor: Colors.amber.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
