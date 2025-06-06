import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/common/data/mapper/post_mapper.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/features/posts_list/data/datasource/local/posts_local_data_source.dart';

import '../../../../common/data/models/post_model.dart';
import '../../../../common/domain/entities/post.dart';
import '../../../../core/data/mapper/base_mapper.dart';
import '../../../../core/error/exception.dart';
import '../../domain/repository/posts_repository.dart';
import '../datasource/remote/posts_remote_data_source.dart';

class PostsRepositoryImpl implements PostsRepository {
  final InternetConnectionChecker _internetConnectionChecker;
  final PostsRemoteDataSource _remoteDataSource;
  final PostsLocalDataSource _localDataSource;
  final BaseMapper<Post, PostModel> _postMapper;

  PostsRepositoryImpl({
    required InternetConnectionChecker internetConnectionChecker,
    required PostsRemoteDataSource remoteDataSource,
    required PostsLocalDataSource localDataSource,
    required BaseMapper<Post, PostModel> postMapper,
  }) : _internetConnectionChecker = internetConnectionChecker,
       _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _postMapper = postMapper;

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    final bool isConnected = await _internetConnectionChecker.hasConnection;
    if (isConnected) {
      try {
        final List<PostModel> posts = await _remoteDataSource.fetchPosts();
        final bool hasCachedPosts = await _localDataSource.hasPosts();
        if (!hasCachedPosts) {
          await _localDataSource.savePosts(posts);
        }
        return Right(posts.map((post) => _postMapper.toEntity(post)).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<PostModel> cachedPost = await _localDataSource.fetchPosts();
        return Right(
          cachedPost.map((post) => _postMapper.toEntity(post)).toList(),
        );
      } on CacheException catch (e) {
        return Left(CacheFailure());
      }
    }
  }
}
