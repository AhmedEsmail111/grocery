import 'package:flutter/material.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class EmptyProducts extends StatelessWidget {
  const EmptyProducts({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/box.png',
            height: height * 0.4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle().copyWith(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
