// AI-ASSISTED: Modified by assistant on 2026-01-19
import 'package:flutter/material.dart';

/// AnimatedScaleButton: wraps a child and provides a tap-scale animation.
class AnimatedScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;

  const AnimatedScaleButton({Key? key, required this.child, this.onTap, this.duration = const Duration(milliseconds: 120)}) : super(key: key);

  @override
  State<AnimatedScaleButton> createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton> with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(_) {
    setState(() => _scale = 0.95);
  }

  void _onTapUp(_) {
    setState(() => _scale = 1.0);
    widget.onTap?.call();
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
