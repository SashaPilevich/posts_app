part of 'post_details_bloc.dart';

abstract class PostDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitEvent extends PostDetailsEvent {}

class PopEvent extends PostDetailsEvent {}
