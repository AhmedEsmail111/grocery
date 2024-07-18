import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class OnSaleMark extends StatelessWidget {
  const OnSaleMark({super.key});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          children: [
            const SizedBox(
              height: 4,
            ),
            Text(
              'ON SALE',
              style: const TextStyle().copyWith(
                color: Colors.deepOrange,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(
              IconlyLight.discount,
              size: 22,
              color: Colors.deepOrange,
            ),
          ],
        ),
      ),
    );
  }
}
