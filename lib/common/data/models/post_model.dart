import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'post_model.freezed.dart';

part 'post_model.g.dart';

@freezed
@HiveType(typeId: 0)
abstract class PostModel with _$PostModel {
  factory PostModel({
    @HiveField(0) @Default(0) int id,
    @HiveField(1) @Default('') String title,
    @HiveField(2) @Default('') String body,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, Object?> json) =>
      _$PostModelFromJson(json);
}
