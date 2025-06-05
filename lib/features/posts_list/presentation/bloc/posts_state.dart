part of 'posts_bloc.dart';

class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Empty extends PostsState {}

class Loading extends PostsState {}

class Loaded extends PostsState {
  final List<Post> posts;

  Loaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class Error extends PostsState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}
