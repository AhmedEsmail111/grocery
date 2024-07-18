import 'package:flutter/material.dart';
import 'package:grocery/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    this.isInAllProducts = true,
    this.catName,
  });
  // to decide wich search method to call
  final bool isInAllProducts;
  //  if we are in the category products then we need it
  final String? catName;
  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final isDark = context.read<ThemeProvider>().isDark;
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: TextField(
        onChanged: (value) {
          productsProvider.saveSearchText(value.trim());
          widget.isInAllProducts
              ? productsProvider.querySearchedProducts(value.trim())
              : productsProvider.queryCategorySearchedProducts(
                  value.trim(),
                  widget.catName!,
                );
        },

        focusNode: _searchFocusNode,
        controller: _searchController,

        style: const TextStyle().copyWith(
          color: isDark ? Colors.white : Colors.black,
        ),
        cursorColor: Colors.blue,
        // cursorHeight: 20,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: 'What\'s in your mind?',
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.greenAccent,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.greenAccent,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            size: 25,
            color: isDark ? Colors.white54 : Colors.black,
          ),
          suffix: Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 16),
            child: IconButton(
                onPressed: () {
                  _searchController.clear();
                  _searchFocusNode.unfocus();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                )),
          ),
        ),
      ),
    );
  }
}
