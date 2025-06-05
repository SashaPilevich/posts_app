import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/domain/entities/post.dart';
import '../bloc/posts_bloc.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PostsBloc>().add(OpenPostDetailsEvent(postId: post.id));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 12,
          children: <Widget>[Text(post.title), Text(post.body)],
        ),
      ),
    );
  }
}
