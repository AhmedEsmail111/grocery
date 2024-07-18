import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeProvider>().isDark;
    return IconButton(
      icon: Icon(
        IconlyLight.arrowLeft2,
        color: isDark ? Colors.white : Colors.black,
        size: 25,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
