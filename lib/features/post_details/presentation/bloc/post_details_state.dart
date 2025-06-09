part of 'post_details_bloc.dart';

class PostDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Empty extends PostDetailsState {}

class Loading extends PostDetailsState {}

class Loaded extends PostDetailsState {
  final Post post;

  Loaded({required this.post});

  @override
  List<Object?> get props => [post];
}

class Error extends PostDetailsState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}
