import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/app_theme.dart';
import '../theme/theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  @override
  final Size preferredSize = Size.fromHeight(48);

  CustomAppBar({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
      title: title != null
          ? Text(
              title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                height: 1.1,
              ),
            )
          : null,
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        Switch(
          value: context.watch<ThemeProvider>().themeMode == ThemeMode.dark,
          onChanged: (bool isDarkTheme) {
            final ThemeProvider themeProvider = context.read<ThemeProvider>();
            themeProvider.setTheme(
              isDarkTheme ? AppTheme.dark : AppTheme.light,
            );
          },
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
