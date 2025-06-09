import 'package:flutter/cupertino.dart';

class AnimatedPostText extends StatefulWidget {
  final String text;

  const AnimatedPostText({required this.text, super.key});

  @override
  State<AnimatedPostText> createState() => _AnimatedPostTextState();
}

class _AnimatedPostTextState extends State<AnimatedPostText> {
  bool _isExpanded = false;

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTap: toggleExpand,
        child: Text(
          widget.text,
          maxLines: _isExpanded ? null : 1,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
