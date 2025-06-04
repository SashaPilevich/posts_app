import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';

import '../../../../common/domain/entities/post.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getPosts();
}
