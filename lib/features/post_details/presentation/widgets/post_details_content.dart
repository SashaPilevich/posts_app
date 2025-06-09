import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/post_details/presentation/widgets/post_details_item.dart';

import '../../../../common/presentation/widgets/widgets.dart';
import '../bloc/post_details_bloc.dart';

class PostDetailsContent extends StatelessWidget {
  const PostDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Post Details'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<PostDetailsBloc, PostDetailsState>(
          builder: (BuildContext context, PostDetailsState state) {
            if (state is Empty) {
              return EmptyStateContent(title: 'No items found');
            } else if (state is Loading) {
              return AppLoader();
            } else if (state is Loaded) {
              return PostDetailsItem(post: state.post);
            } else if (state is Error) {
              return AppErrorContent(errorMessage: state.message);
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
