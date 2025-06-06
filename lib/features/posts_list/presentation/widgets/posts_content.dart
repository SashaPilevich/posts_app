import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts_list/presentation/widgets/posts_list.dart';

import '../../../../common/presentation/widgets/app_empty_state_content.dart';
import '../../../../common/presentation/widgets/app_error_content.dart';
import '../../../../common/presentation/widgets/app_loader.dart';
import '../../../../common/presentation/widgets/custom_app_bar.dart';
import '../bloc/posts_bloc.dart';

class PostsContent extends StatelessWidget {
  const PostsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Posts List', showBackButton: false),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PostsBloc>().add(InitEvent());
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (BuildContext context, PostsState state) {
              if (state is Empty) {
                return EmptyStateContent(title: 'No items found');
              } else if (state is Loading) {
                return AppLoader();
              } else if (state is Loaded) {
                return PostsList(posts: state.posts);
              } else if (state is Error) {
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
