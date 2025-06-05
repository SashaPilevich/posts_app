import 'package:posts_app/core/error/exception.dart';
import 'package:posts_app/features/posts_list/data/api_service/posts_api_service.dart';
import 'package:posts_app/features/posts_list/data/datasource/remote/posts_remote_data_source.dart';

import '../../../../../common/data/models/post_model.dart';

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final PostsApiService _postsApiService;

  PostsRemoteDataSourceImpl({required PostsApiService postsApiService})
    : _postsApiService = postsApiService;

  @override
  Future<List<PostModel>> fetchPosts() async {
    try {
      return await _postsApiService.fetchPosts();
    } catch (e) {
      throw ServerException();
    }
  }
}
