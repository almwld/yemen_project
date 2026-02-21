import 'package:flutter/material.dart';

class FlexButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  FlexButton({required this.text, required this.onPressed, this.color = Colors.amber});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
