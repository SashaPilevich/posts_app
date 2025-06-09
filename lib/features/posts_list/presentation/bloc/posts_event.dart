part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitEvent extends PostsEvent {}

class RefreshEvent extends PostsEvent {}

class OpenPostDetailsEvent extends PostsEvent {
  final int postId;

  OpenPostDetailsEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}
