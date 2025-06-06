import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts_list/domain/usecase/get_posts_list_usecase.dart';

import '../../../../common/domain/entities/post.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

const String serverFailureMessage =
    'An error occurred. Please try again later.';
const String cacheFailureMessage = 'An error occurred. Please try again later.';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUseCase _getPostsUseCase;

  PostsBloc({required GetPostsUseCase getPostsUseCase})
    : _getPostsUseCase = getPostsUseCase,
      super(Loading()) {
    on<InitEvent>(_onInit);
    on<OpenPostDetailsEvent>(_onOpenPostDetails);

    add(InitEvent());
  }

  Future<void> _onInit(InitEvent event, Emitter<PostsState> emit) async {
    emit(Loading());
    final Either<Failure, List<Post>> result = await _getPostsUseCase(
      NoParams(),
    );
    result.fold(
      (failure) => emit(Error(message: _mapFailureToMessage(failure))),
      (posts) => emit(posts.isNotEmpty ? Loaded(posts: posts) : Empty()),
    );
  }

  Future<void> _onOpenPostDetails(
    OpenPostDetailsEvent event,
    Emitter<PostsState> emit,
  ) async {
    /// TODO: navigate to postDetails
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
