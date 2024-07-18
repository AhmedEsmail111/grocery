import 'package:flutter/material.dart';

class CustomErrorDialogue extends StatelessWidget {
  const CustomErrorDialogue({
    super.key,
    // required this.title,
    required this.contentText,
    this.widgetContext,
  });
  // final String title;

  final String contentText;
  final BuildContext? widgetContext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Image.asset(
            'assets/images/warning-sign.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            'Error!',
            style: const TextStyle().copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: Text(
        contentText,
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: const Text(
            'Ok',
            style: TextStyle(color: Colors.lightBlue),
          ),
        ),
      ],
    );
  }
}
