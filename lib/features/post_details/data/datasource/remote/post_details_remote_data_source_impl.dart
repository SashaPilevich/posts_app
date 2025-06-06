import 'package:posts_app/features/post_details/data/datasource/remote/post_details_remote_data_source.dart';

import '../../../../../common/data/models/post_model.dart';
import '../../../../../core/error/exception.dart';
import '../../api_service/post_details_api_service.dart';

class PostDetailsRemoteDataSourceImpl implements PostDetailsRemoteDataSource {
  final PostDetailsApiService postDetailsApiService;

  PostDetailsRemoteDataSourceImpl({required this.postDetailsApiService});

  @override
  Future<PostModel> fetchPostDetails(int id) async {
    try {
      return await postDetailsApiService.fetchPostDetails(id);
    } catch (_) {
      throw ServerException();
    }
  }
}
