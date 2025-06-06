import 'package:flutter/material.dart';

class EmptyStateContent extends StatelessWidget {
  final String title;

  const EmptyStateContent({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
