import 'package:flutter/material.dart';

class GoldShimmer extends StatefulWidget {
  final Widget child;
  GoldShimmer({required this.child});

  @override
  _GoldShimmerState createState() => _GoldShimmerState();
}

class _GoldShimmerState extends State<GoldShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.amber.withOpacity(0.1), Colors.amber, Colors.amber.withOpacity(0.1)],
              stops: [_controller.value - 0.3, _controller.value, _controller.value + 0.3],
            ).createShader(rect);
          },
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
