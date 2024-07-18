import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/core/widgets/alert_dialogue.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> showAlertDialogue({
  required BuildContext context,
  required String title,
  required String content,
  required void Function() onPressed,
}) async {
  await showDialog(
    context: context,
    builder: (_) => CustomAlertDialogue(
      title: title,
      contentText: content,
      onPressed: onPressed,
    ),
  );
}

Future<bool?> showToastMsg(
    {required String message, required BuildContext context}) {
  final isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: isDark ? Colors.grey : const Color(0xFF00001a),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
