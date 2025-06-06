import '../../../core/data/mapper/base_mapper.dart';
import '../../domain/entities/post.dart';
import '../models/post_model.dart';

class PostMapper implements BaseMapper<Post, PostModel> {
  @override
  PostModel toModel(Post entity) {
    return PostModel(id: entity.id, title: entity.title, body: entity.body);
  }

  @override
  Post toEntity(PostModel model) {
    return Post(id: model.id, title: model.title, body: model.body);
  }
}
