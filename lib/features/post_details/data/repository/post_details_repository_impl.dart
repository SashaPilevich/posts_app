import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/data/mapper/base_mapper.dart';
import 'package:posts_app/core/error/failures.dart';

import '../../../../common/data/models/post_model.dart';
import '../../../../common/domain/entities/post.dart';
import '../../../../core/error/exception.dart';
import '../../domain/repository/post_details_repository.dart';
import '../datasource/local/post_details_local_data_source.dart';
import '../datasource/remote/post_details_remote_data_source.dart';

class PostDetailsRepositoryImpl implements PostDetailsRepository {
  final InternetConnectionChecker internetConnectionChecker;
  final PostDetailsRemoteDataSource remoteDataSource;
  final PostDetailsLocalDataSource localDataSource;
  final BaseMapper<Post, PostModel> postMapper;

  PostDetailsRepositoryImpl({
    required this.internetConnectionChecker,
    required this.remoteDataSource,
    required this.localDataSource,
    required this.postMapper,
  });

  @override
  Future<Either<Failure, Post>> getPostDetails(int postId) async {
    final bool isConnected = await internetConnectionChecker.hasConnection;
    if (isConnected) {
      try {
        final PostModel post = await remoteDataSource.fetchPostDetails(postId);
        final bool hasCachedPost = await localDataSource.hasPost();
        if (!hasCachedPost) {
          await localDataSource.savePost(post);
        }
        return Right(postMapper.toEntity(post));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final PostModel cachedPost = await localDataSource.fetchPost();
        return Right(postMapper.toEntity(cachedPost));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
