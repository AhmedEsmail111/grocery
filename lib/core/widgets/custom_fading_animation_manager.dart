import 'package:flutter/material.dart';

class CustomFadingAnimationManager extends StatefulWidget {
  const CustomFadingAnimationManager({super.key, required this.child});

  final Widget child;

  @override
  State<CustomFadingAnimationManager> createState() =>
      _CustomFadingAnimationManagerState();
}

class _CustomFadingAnimationManagerState
    extends State<CustomFadingAnimationManager>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _animation;

  @override
  void initState() {
    _initFadingAnimation();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _animation.value,
      child: widget.child,
    );
  }

  void _initFadingAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation =
        Tween<double>(begin: 0.4, end: 0.8).animate(_animationController);

    _animationController.repeat(reverse: true);

    _animationController.addListener(() {
      setState(() {});
    });
  }
}
