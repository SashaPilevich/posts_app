import '../../../../../common/data/models/post_model.dart';

abstract class PostDetailsRemoteDataSource {
  Future<PostModel> fetchPostDetails(int id);
}
