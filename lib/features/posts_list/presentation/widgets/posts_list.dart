import 'package:flutter/material.dart';
import 'package:posts_app/features/posts_list/presentation/widgets/post_item.dart';

import '../../../../common/domain/entities/post.dart';

class PostsList extends StatelessWidget {
  final List<Post> posts;

  const PostsList({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        final Post post = posts[index];
        return PostItem(post: post);
      },
    );
  }
}
