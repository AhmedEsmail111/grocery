import 'package:flutter/material.dart';

class RedirectAuthenticationRow extends StatelessWidget {
  const RedirectAuthenticationRow({
    super.key,
    required this.contextText,
    required this.redirectText,
    this.onTap,
  });
  final String contextText;
  final String redirectText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          contextText,
          style: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            redirectText,
            style: const TextStyle().copyWith(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
