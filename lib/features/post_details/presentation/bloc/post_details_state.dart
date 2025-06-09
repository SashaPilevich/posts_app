part of 'post_details_bloc.dart';

class PostDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostDetailsEmpty extends PostDetailsState {}

class PostDetailsLoading extends PostDetailsState {}

class PostDetailsLoaded extends PostDetailsState {
  final Post post;

  PostDetailsLoaded({required this.post});

  @override
  List<Object?> get props => [post];
}

class PostDetailsError extends PostDetailsState {
  final String message;

  PostDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
