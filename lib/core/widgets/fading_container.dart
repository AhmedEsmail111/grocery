import 'package:flutter/material.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class FadingContainer extends StatelessWidget {
  const FadingContainer({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isDark ? Colors.white70 : Colors.grey,
      ),
      width: width,
      height: height,
    );
  }
}
