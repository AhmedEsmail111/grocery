import 'package:flutter/material.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:grocery/views/all_products/all_products_view.dart';
import 'package:provider/provider.dart';

import 'custom_button.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {super.key,
      required this.imagePath,
      required this.content,
      required this.buttonText});

  final String imagePath;
  final String content;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeProvider>().isDark;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: MediaQuery.sizeOf(context).height * 0.4,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Whoops!',
              style: const TextStyle().copyWith(
                fontSize: 45,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              content,
              style: const TextStyle().copyWith(
                fontSize: 20,
                color: Colors.cyan,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 35,
            ),
            CustomButton(
              borderRadius: 8,
              width: 180,
              height: 60,
              background: Theme.of(context).colorScheme.secondary,
              text: buttonText,
              textColor: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AllProductsView(),
                  ),
                );
              },
            ),
          ],
        )),
      )),
    );
  }
}
