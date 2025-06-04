import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String text;

  const Post({required this.id, required this.title, required this.text});

  @override
  List<Object?> get props => [id, title, text];
}
