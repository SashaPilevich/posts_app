import 'package:flutter/material.dart';

class AppErrorContent extends StatelessWidget {
  final String errorMessage;

  const AppErrorContent({required this.errorMessage, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
