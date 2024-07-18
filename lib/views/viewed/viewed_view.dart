import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/core/widgets/empty_screen.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:grocery/providers/viewed_provider.dart';
import 'package:provider/provider.dart';

import '../../core/utils/functions.dart';
import '../../core/widgets/back_button.dart';
import 'widgets/viewed_list_view.dart';

class ViewedView extends StatelessWidget {
  const ViewedView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final color = isDark ? Colors.white : Colors.black;
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final viewedList = viewedProvider.viewedItems.values.toList();
    return viewedList.isEmpty
        ? const EmptyScreen(
            imagePath: 'assets/images/history.png',
            content: 'Your history is empty\nNo products have been viewed yet!',
            buttonText: 'Shop now',
          )
        : Scaffold(
            appBar: AppBar(
              leading: const CustomBackButton(),
              title: Text(
                'History',
                style: const TextStyle()
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 24),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    showAlertDialogue(
                      context: context,
                      title: 'Clear History',
                      content: 'Your History will be cleared!',
                      onPressed: viewedProvider.clearViewed,
                    );
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                ),
              ],
            ),
            body: const ViewedListView(),
          );
  }
}
