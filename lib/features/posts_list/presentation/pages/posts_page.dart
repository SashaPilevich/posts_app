import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/app_di/injection_container.dart';
import 'package:posts_app/common/presentation/widgets/app_empty_state_content.dart';
import 'package:posts_app/common/presentation/widgets/app_error_content.dart';
import 'package:posts_app/features/posts_list/domain/usecase/get_posts_list_usecase.dart';
import 'package:posts_app/features/posts_list/presentation/bloc/posts_bloc.dart';
import 'package:posts_app/features/posts_list/presentation/widgets/posts_list.dart';

import '../../../../common/presentation/widgets/app_loader.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostsBloc>(
      create: (_) {
        return PostsBloc(
          getPostsUseCase: DIContainer.scope.resolve<GetPostsUseCase>(),
        );
      },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<PostsBloc, PostsState>(
          builder: (BuildContext context, PostsState state) {
            if (state is Empty) {
              return EmptyStateContent();
            } else if (state is Loading) {
              return AppLoader();
            } else if (state is Loaded) {
              return PostsList(posts: state.posts);
            } else if (state is Error) {
              return AppErrorContent();
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
