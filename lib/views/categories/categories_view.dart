import 'package:flutter/material.dart';
import 'package:grocery/core/utils/contants.dart';
import 'package:grocery/views/categories/category_box.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Categories'),
      ),
      body: GridView.builder(
        itemCount: catBackgroundColors.length,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.05,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        itemBuilder: ((context, index) => CategoryBoxItem(
              color: catBackgroundColors[index],
              borderColor: catBackgroundColors[index],
              category: catInfoMap[index]['catText'],
              imagePath: catInfoMap[index]['imgPath'],
            )),
      ),
    );
  }
}
