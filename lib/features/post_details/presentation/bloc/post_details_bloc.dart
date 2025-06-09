import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/post_details/domain/usecase/get_post_details_usecase.dart';

import '../../../../common/domain/entities/post.dart';
import '../../../../core/error/failures.dart';

part 'post_details_event.dart';
part 'post_details_state.dart';

const String serverFailureMessage = 'An error occurred. Please try again later.';
const String cacheFailureMessage = 'An error occurred. Please try again later.';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  final GetPostDetailsUseCase _getPostDetailsUseCase;

  PostDetailsBloc({required GetPostDetailsUseCase getPostDetailsUseCase})
    : _getPostDetailsUseCase = getPostDetailsUseCase,
      super(Loading()) {
    on<InitEvent>(_onInit);
  }

  Future<void> _onInit(InitEvent event, Emitter<PostDetailsState> emit) async {
    emit(Loading());
    final Either<Failure, Post> result = await _getPostDetailsUseCase.execute(event.postId);
    result.fold(
      (failure) => emit(Error(message: _mapFailureToMessage(failure))),
      (post) => emit(Loaded(post: post)),
    );
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
