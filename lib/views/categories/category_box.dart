import 'package:flutter/material.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../cat_products/category_products_view.dart';

class CategoryBoxItem extends StatelessWidget {
  const CategoryBoxItem({
    super.key,
    required this.color,
    required this.borderColor,
    required this.category,
    // required this.onTap,
    required this.imagePath,
  });
  final Color color;
  final Color borderColor;
  final String category;

  // final void Function() onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryProductsView(
              catName: category,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          border: Border.all(color: borderColor.withOpacity(0.7), width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                category,
                style: const TextStyle().copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
