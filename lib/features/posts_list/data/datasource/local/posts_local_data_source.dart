import '../../../../../common/data/models/post_model.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> fetchPosts();

  Future<void> savePosts(List<PostModel> posts);

  Future<bool> hasPosts();
}
