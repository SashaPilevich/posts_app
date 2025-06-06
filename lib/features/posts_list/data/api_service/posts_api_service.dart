import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../common/data/models/post_model.dart';

part 'posts_api_service.g.dart';

@RestApi()
abstract class PostsApiService {
  factory PostsApiService(Dio dio, {String? baseUrl}) = _PostsApiService;

  @GET('/posts')
  Future<List<PostModel>> fetchPosts();
}
