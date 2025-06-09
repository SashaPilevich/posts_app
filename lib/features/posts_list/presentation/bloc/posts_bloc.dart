import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts_list/domain/usecase/get_posts_list_usecase.dart';

import '../../../../common/domain/entities/post.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../navigation/navigation.dart';
import '../posts_list_text.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final AppRouter _appRouter;
  final GetPostsUseCase _getPostsUseCase;

  PostsBloc({
    required GetPostsUseCase getPostsUseCase,
    required AppRouter appRouter,
  }) : _getPostsUseCase = getPostsUseCase,
       _appRouter = appRouter,
       super(PostsLoading()) {
    on<InitEvent>(_onInit);
    on<RefreshEvent>(_onRefresh);
    on<OpenPostDetailsEvent>(_onOpenPostDetails);

    add(InitEvent());
  }

  Future<void> _onInit(InitEvent event, Emitter<PostsState> emit) async {
    await _fetchPosts(emit);
  }

  Future<void> _onRefresh(RefreshEvent event, Emitter<PostsState> emit) async {
    await _fetchPosts(emit);
  }

  Future<void> _fetchPosts(Emitter<PostsState> emit) async {
    emit(PostsLoading());
    final Either<Failure, List<Post>> result = await _getPostsUseCase.execute(
      NoParams(),
    );
    result.fold(
      (failure) => emit(PostsError(message: _mapFailureToMessage(failure))),
      (posts) =>
          emit(posts.isNotEmpty ? PostsLoaded(posts: posts) : PostsEmpty()),
    );
  }

  Future<void> _onOpenPostDetails(
    OpenPostDetailsEvent event,
    Emitter<PostsState> emit,
  ) async {
    _appRouter.push(PostDetailsRoute(postId: event.postId));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return PostsListText.serverErrorMessage;
      case CacheFailure:
        return PostsListText.cacheErrorMessage;
      default:
        return PostsListText.unexpectedErrorMessage;
    }
  }
}
