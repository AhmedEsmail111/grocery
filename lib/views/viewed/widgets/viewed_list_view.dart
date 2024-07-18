import 'package:flutter/material.dart';
import 'package:grocery/views/viewed/widgets/viewed_item.dart';
import 'package:provider/provider.dart';

import '../../../providers/viewed_provider.dart';

class ViewedListView extends StatelessWidget {
  const ViewedListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final viewedList =
        viewedProvider.viewedItems.values.toList().reversed.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: ListView.separated(
        itemCount: viewedList.length,
        itemBuilder: ((context, index) => ChangeNotifierProvider.value(
            value: viewedList[index], child: const ViewedItemTile())),
        separatorBuilder: (ctx, index) => const SizedBox(
          height: 20,
        ),
      ),
    );
  }
}
