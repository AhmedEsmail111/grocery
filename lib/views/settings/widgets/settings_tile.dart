import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.withSwitch = false,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String subTitle;
  final bool withSwitch;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      titleAlignment: ListTileTitleAlignment.titleHeight,
      onTap: onTap,
      leading: Icon(
        icon,
        color: themeProvider.isDark ? Colors.white : Colors.black45,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: themeProvider.isDark ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
          color: themeProvider.isDark ? Colors.white : Colors.black,
        ),
      ),
      trailing: withSwitch
          ? Switch(
              value: themeProvider.isDark,
              onChanged: (value) {
                themeProvider.setDartMode(value);
              },
            )
          : Icon(
              IconlyLight.arrowRight2,
              color: themeProvider.isDark ? Colors.white : Colors.black45,
            ),
    );
  }
}
