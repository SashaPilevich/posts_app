import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../common/data/models/post_model.dart';

part 'post_details_api_service.g.dart';

@RestApi()
abstract class PostDetailsApiService {
  factory PostDetailsApiService(Dio dio, {String? baseUrl}) =
      _PostDetailsApiService;

  @GET('/posts/{id}')
  Future<PostModel> fetchPostDetails(@Path() int id);
}
