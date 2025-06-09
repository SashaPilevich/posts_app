import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/app_di/di_container.dart';

import '../../domain/usecase/get_post_details_usecase.dart';
import '../bloc/post_details_bloc.dart';
import '../widgets/post_details_content.dart';

@RoutePage()
class PostDetailsPage extends StatelessWidget {
  final int postId;

  const PostDetailsPage({required this.postId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return PostDetailsBloc(
          getPostDetailsUseCase: DIContainer.scope
              .resolve<GetPostDetailsUseCase>(),
        )..add(InitEvent(postId: postId));
      },
      child: PostDetailsContent(),
    );
  }
}
