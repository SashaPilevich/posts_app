import '../../../../../common/data/models/post_model.dart';

abstract class PostDetailsLocalDataSource {
  Future<PostModel> fetchPost();

  Future<void> savePost(PostModel post);

  Future<bool> hasPost();
}
