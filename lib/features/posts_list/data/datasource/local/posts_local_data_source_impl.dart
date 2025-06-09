import 'dart:convert';

import 'package:posts_app/common/data/models/post_model.dart';
import 'package:posts_app/core/error/exception.dart';
import 'package:posts_app/features/posts_list/data/datasource/local/posts_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final SharedPreferences _sharedPreferences;
  final String _postsListKey = 'posts_list';

  PostsLocalDataSourceImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<List<PostModel>> fetchPosts() async {
    List<String>? jsonStringList = _sharedPreferences.getStringList(_postsListKey);

    if (jsonStringList != null) {
      return jsonStringList
          .map((jsonString) => PostModel.fromJson(jsonDecode(jsonString)))
          .toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> savePosts(List<PostModel> posts) async {
    List<String> jsonStringList = posts.map((post) => jsonEncode(post.toJson())).toList();
    await _sharedPreferences.setStringList(_postsListKey, jsonStringList);
  }

  @override
  Future<bool> hasPosts() async {
    return _sharedPreferences.containsKey(_postsListKey) &&
        _sharedPreferences.getStringList(_postsListKey)?.isNotEmpty == true;
  }
}
