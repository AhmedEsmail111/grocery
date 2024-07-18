import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class GoBackIconButton extends StatelessWidget {
  const GoBackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Icon(
        IconlyLight.arrowLeft2,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
