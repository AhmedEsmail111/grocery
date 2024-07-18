import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width - 70;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            width: width * 0.48,
            height: 2,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            'OR',
            style:
                const TextStyle().copyWith(color: Colors.white, fontSize: 18),
          ),
        ),
        Flexible(
          child: Container(
            width: width * 0.48,
            height: 2,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
