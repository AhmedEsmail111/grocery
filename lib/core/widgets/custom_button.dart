import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height,
    required this.background,
    this.width,
    required this.text,
    this.textColor,
    this.elevation = 0,
    this.onTap,
    required this.borderRadius,
  });
  final Color? textColor;
  final double height;
  final double? width;
  final Color background;
  final String text;
  final double elevation;
  final void Function()? onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: background,
      ),
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: background,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: onTap,
        child: RichText(
          text: TextSpan(
            text: text,
            style: const TextStyle().copyWith(
                fontSize: 18,
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
