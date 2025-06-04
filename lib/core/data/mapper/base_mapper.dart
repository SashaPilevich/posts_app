///class to convert [Model] to [Entity] and vice versa.
abstract interface class BaseMapper<Entity, Model> {
  Model toModel(Entity entity);

  Entity toEntity(Model model);
}
