import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/app_di/di_container.dart';
import 'package:posts_app/features/posts_list/domain/usecase/get_posts_list_usecase.dart';
import 'package:posts_app/features/posts_list/presentation/bloc/posts_bloc.dart';
import 'package:posts_app/features/posts_list/presentation/widgets/posts_content.dart';

@RoutePage()
class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostsBloc>(
      create: (BuildContext context) {
        return PostsBloc(getPostsUseCase: DIContainer.scope.resolve<GetPostsUseCase>());
      },
      child: PostsContent(),
    );
  }
}
