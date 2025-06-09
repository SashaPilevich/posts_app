part of 'post_details_bloc.dart';

abstract class PostDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitEvent extends PostDetailsEvent {
  final int postId;

  InitEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}
