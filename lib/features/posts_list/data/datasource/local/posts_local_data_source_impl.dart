import 'package:hive/hive.dart';
import 'package:posts_app/common/data/models/post_model.dart';
import 'package:posts_app/core/error/exception.dart';
import 'package:posts_app/features/posts_list/data/datasource/local/posts_local_data_source.dart';

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  late Box<List<PostModel>> _postsBox;
  final String _key = 'posts';

  //call this method in di after registration
  @override
  Future<void> init() async {
    Hive.registerAdapter(PostModelAdapter());
    _postsBox = await Hive.openBox(_key);
  }

  @override
  Future<List<PostModel>> fetchPosts() async {
    try {
      final List<PostModel> posts = _postsBox.get(_key) ?? <PostModel>[];
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
      await _postsBox.put(_key, posts);
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
    return _postsBox.containsKey(_key) &&
        (_postsBox.get(_key)?.isNotEmpty ?? false);
  }
}
