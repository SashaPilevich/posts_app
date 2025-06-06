import 'package:hive/hive.dart';
import 'package:posts_app/common/data/models/post_model.dart';
import 'package:posts_app/core/error/exception.dart';
import 'package:posts_app/features/posts_list/data/datasource/local/posts_local_data_source.dart';

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  late Box<PostModel> _postsBox;
  final String _key = 'posts';

  @override
  Future<void> init() async {
    Hive.registerAdapter(PostModelAdapter());
    _postsBox = await Hive.openBox(_key);
  }

  @override
  Future<List<PostModel>> fetchPosts() async {
    try {
      final List<PostModel> posts = _postsBox.values.toList();
      if (posts.isEmpty) {
        throw CacheException();
      }
      return posts;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> savePosts(List<PostModel> posts) async {
    try {
      await _postsBox.putAll({
        for (final PostModel post in posts) post.id: post,
      });
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearPosts() async {
    await _postsBox.clear();
  }

  @override
  Future<bool> hasPosts() async {
    return _postsBox.values.toList().isNotEmpty;
  }
}
