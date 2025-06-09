import 'package:flutter/material.dart';

import '../../../../common/domain/entities/post.dart';

class PostDetailsItem extends StatefulWidget {
  final Post post;

  const PostDetailsItem({required this.post, super.key});

  @override
  State<PostDetailsItem> createState() => _PostDetailsItemState();
}

class _PostDetailsItemState extends State<PostDetailsItem>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> titleOpacity;
  late Animation<double> titleScale;
  late Animation<double> bodyOpacity;
  late Animation<double> bodyScale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    titleScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    bodyOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeInOut),
      ),
    );

    bodyScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Opacity(
                opacity: titleOpacity.value,
                child: ScaleTransition(
                  scale: titleScale,
                  child: Text(
                    widget.post.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Opacity(
                opacity: bodyOpacity.value,
                child: ScaleTransition(
                  scale: bodyScale,
                  child: Text(
                    widget.post.body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
