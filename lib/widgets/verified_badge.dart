import 'package:flutter/material.dart';

class VerifiedBadge extends StatelessWidget {
  final String status;
  VerifiedBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 'approved') {
      return Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: Icon(Icons.verified, color: Colors.blue, size: 18),
      );
    }
    return SizedBox.shrink();
  }
}
