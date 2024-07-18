import 'package:flutter/material.dart';

class ChangeQuantityIcon extends StatelessWidget {
  const ChangeQuantityIcon(
      {super.key,
      required this.icon,
      required this.backgroundColor,
      this.onTap});
  final IconData icon;
  final Color backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
