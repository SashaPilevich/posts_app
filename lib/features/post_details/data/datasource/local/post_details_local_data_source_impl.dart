import 'dart:convert';

import 'package:posts_app/core/error/exception.dart';
import 'package:posts_app/features/post_details/data/datasource/local/post_details_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common/data/models/post_model.dart';

class PostDetailsLocalDataSourceImpl implements PostDetailsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostDetailsLocalDataSourceImpl({required this.sharedPreferences});

  final String _postKey = 'post';

  @override
  Future<void> savePost(PostModel post) async {
    String jsonStringPost = jsonEncode(post.toJson());
    await sharedPreferences.setString(_postKey, jsonStringPost);
  }

  @override
  Future<PostModel> fetchPost() async {
    final String? jsonString = sharedPreferences.getString(_postKey);
    if (jsonString != null) {
      return PostModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> hasPost() async {
    return sharedPreferences.containsKey(_postKey) && sharedPreferences.getString(_postKey) != null;
  }
}
