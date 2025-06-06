import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leadingWidget;
  final VoidCallback? onTapBack;
  final bool showBackButton;

  @override
  final Size preferredSize = Size.fromHeight(48);

  CustomAppBar({
    this.title,
    this.leadingWidget,
    this.onTapBack,
    this.showBackButton = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      leading:
          leadingWidget ??
          Visibility(
            visible: showBackButton,
            child: GestureDetector(
              onTap: onTapBack,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 16),
                child: Icon(Icons.arrow_back, size: 24, color: Theme.of(context).iconTheme.color),
              ),
            ),
          ),
      actions: <Widget>[
        Switch(value: true, onChanged: (_) {}),
        SizedBox(width: 16),
      ],
    );
  }
}
