import '../../../../../common/data/models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> fetchPosts();
}
