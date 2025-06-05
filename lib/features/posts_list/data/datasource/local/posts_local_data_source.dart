import '../../../../../common/data/models/post_model.dart';

abstract class PostsLocalDataSource {
  Future<void> init();

  Future<List<PostModel>> fetchPosts();

  Future<void> savePosts(List<PostModel> posts);

  Future<void> clearPosts();

  Future<bool> hasPosts();
}
