import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts_list/presentation/posts_list_text.dart';
import 'package:posts_app/features/posts_list/presentation/widgets/posts_list.dart';

import '../../../../common/presentation/widgets/widgets.dart';
import '../bloc/posts_bloc.dart';

class PostsContent extends StatelessWidget {
  const PostsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: PostsListText.postsList),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PostsBloc>().add(RefreshEvent());
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (BuildContext context, PostsState state) {
              if (state is PostsEmpty) {
                return EmptyStateContent(
                  title: PostsListText.emptyStateMessage,
                );
              } else if (state is PostsLoading) {
                return AppLoader();
              } else if (state is PostsLoaded) {
                return PostsList(posts: state.posts);
              } else if (state is PostsError) {
                return AppErrorContent(errorMessage: state.message);
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
