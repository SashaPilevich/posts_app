import 'package:dartz/dartz.dart';
import 'package:posts_app/common/domain/entities/post.dart';
import 'package:posts_app/core/error/failures.dart';

abstract class PostDetailsRepository {
  Future<Either<Failure, Post>> getPostDetails(String postId);
}
