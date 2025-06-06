import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/error/failures.dart';

import '../../../../common/data/mapper/post_mapper.dart';
import '../../../../common/data/models/post_model.dart';
import '../../../../common/domain/entities/post.dart';
import '../../../../core/error/exception.dart';
import '../../domain/repository/post_details_repository.dart';
import '../datasource/local/post_details_local_data_source.dart';
import '../datasource/remote/post_details_remote_data_source.dart';

class PostDetailsRepositoryImpl implements PostDetailsRepository {
  final InternetConnectionChecker _internetConnectionChecker;
  final PostDetailsRemoteDataSource _remoteDataSource;
  final PostDetailsLocalDataSource _localDataSource;
  final PostMapper _postMapper;

  PostDetailsRepositoryImpl({
    required InternetConnectionChecker internetConnectionChecker,
    required PostDetailsRemoteDataSource remoteDataSource,
    required PostDetailsLocalDataSource localDataSource,
    required PostMapper postMapper,
  }) : _internetConnectionChecker = internetConnectionChecker,
       _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _postMapper = postMapper;

  @override
  Future<Either<Failure, Post>> getPostDetails(int postId) async {
    final bool isConnected = await _internetConnectionChecker.hasConnection;
    if (isConnected) {
      try {
        final PostModel post = await _remoteDataSource.fetchPostDetails(postId);
        final bool hasCachedPost = await _localDataSource.hasPost();
        if (!hasCachedPost) {
          await _localDataSource.savePost(post);
        }
        return Right(_postMapper.toEntity(post));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final PostModel cachedPost = await _localDataSource.fetchPost();
        return Right(_postMapper.toEntity(cachedPost));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
