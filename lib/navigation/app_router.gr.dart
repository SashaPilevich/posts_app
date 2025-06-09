// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:posts_app/features/post_details/presentation/pages/post_details_page.dart'
    as _i1;
import 'package:posts_app/features/posts_list/presentation/pages/posts_page.dart'
    as _i2;

/// generated route for
/// [_i1.PostDetailsPage]
class PostDetailsRoute extends _i3.PageRouteInfo<PostDetailsRouteArgs> {
  PostDetailsRoute({
    required int postId,
    _i4.Key? key,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          PostDetailsRoute.name,
          args: PostDetailsRouteArgs(
            postId: postId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PostDetailsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostDetailsRouteArgs>();
      return _i1.PostDetailsPage(
        postId: args.postId,
        key: args.key,
      );
    },
  );
}

class PostDetailsRouteArgs {
  const PostDetailsRouteArgs({
    required this.postId,
    this.key,
  });

  final int postId;

  final _i4.Key? key;

  @override
  String toString() {
    return 'PostDetailsRouteArgs{postId: $postId, key: $key}';
  }
}

/// generated route for
/// [_i2.PostsPage]
class PostsRoute extends _i3.PageRouteInfo<void> {
  const PostsRoute({List<_i3.PageRouteInfo>? children})
      : super(
          PostsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PostsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.PostsPage();
    },
  );
}
