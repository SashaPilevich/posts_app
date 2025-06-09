import 'package:dartz/dartz.dart';
import 'package:posts_app/core/usecase/usecase.dart';

import '../../../../common/domain/entities/post.dart';
import '../../../../core/error/failures.dart';
import '../repository/post_details_repository.dart';

class GetPostDetailsUseCase implements FutureUseCase<int, Post> {
  final PostDetailsRepository _repository;

  GetPostDetailsUseCase({required PostDetailsRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, Post>> execute(int postId) async {
    return _repository.getPostDetails(postId);
  }
}
