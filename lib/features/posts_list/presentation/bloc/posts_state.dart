part of 'posts_bloc.dart';

class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsEmpty extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  PostsLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class PostsError extends PostsState {
  final String message;

  PostsError({required this.message});

  @override
  List<Object?> get props => [message];
}
