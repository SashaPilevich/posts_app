import 'package:dartz/dartz.dart';

import '../../../../common/domain/entities/post.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/posts_repository.dart';

class GetPostsUseCase implements FutureUseCase<NoParams, List<Post>> {
  final PostsRepository _repository;

  GetPostsUseCase({required PostsRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, List<Post>>> execute(NoParams params) async {
    return await _repository.getPosts();
  }
}
