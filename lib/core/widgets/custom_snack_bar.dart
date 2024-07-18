import 'package:flutter/material.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

SnackBar buildCustomSnackBar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
  required IconData icon,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
}) {
  final isDark = context.read<ThemeProvider>().isDark;
  final color = isDark ? Colors.grey : const Color(0xFF00001a);
  return SnackBar(
    margin: margin,
    padding: padding,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    content: Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor ?? color, // Customize the background color
    behavior: context.mounted
        ? SnackBarBehavior.floating
        : SnackBarBehavior.fixed, // Make it float above other widgets
    duration: const Duration(seconds: 3), // Show for 3 seconds
  );
}
