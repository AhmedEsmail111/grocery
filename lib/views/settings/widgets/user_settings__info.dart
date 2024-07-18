import 'package:flutter/material.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class UserSettingsInfo extends StatelessWidget {
  const UserSettingsInfo({
    super.key,
    required this.userName,
    required this.userEmail,
  });
  final String userName;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: 'Hi,  ',
              style: const TextStyle(
                color: Colors.cyan,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: userName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: isDark == true ? Colors.white : Colors.black,
                  ),
                )
              ]),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          userEmail,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
