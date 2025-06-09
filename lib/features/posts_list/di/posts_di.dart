import 'package:cherrypick/cherrypick.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/features/posts_list/data/datasource/local/posts_local_data_source.dart';
import 'package:posts_app/features/posts_list/data/datasource/local/posts_local_data_source_impl.dart';
import 'package:posts_app/features/posts_list/data/datasource/remote/posts_remote_data_source.dart';
import 'package:posts_app/features/posts_list/data/datasource/remote/posts_remote_data_source_impl.dart';
import 'package:posts_app/features/posts_list/data/repository/posts_repository_impl.dart';
import 'package:posts_app/features/posts_list/domain/repository/posts_repository.dart';
import 'package:posts_app/features/posts_list/domain/usecase/get_posts_list_usecase.dart';
import 'package:posts_app/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/data/mapper/post_mapper.dart';
import '../data/api_service/posts_api_service.dart';

class PostsDiModule extends Module {
  @override
  void builder(Scope currentScope) {
    _bindMappers(currentScope);
    _bindApiService(currentScope);
    _bindDataSources(currentScope);
    _bindRepositories(currentScope);
    _bindUseCases(currentScope);
  }

  void _bindMappers(Scope scope) {
    bind<PostMapper>().toProvide(() => PostMapper()).singleton();
  }

  void _bindApiService(Scope scope) {
    bind<PostsApiService>()
        .toProvide(() => PostsApiService(scope.resolve<DioClient>().dio))
        .singleton();
  }

  void _bindDataSources(Scope scope) {
    bind<PostsRemoteDataSource>()
        .toProvide(
          () => PostsRemoteDataSourceImpl(
            postsApiService: scope.resolve<PostsApiService>(),
          ),
        )
        .singleton();

    bind<PostsLocalDataSource>()
        .toProvide(
          () => PostsLocalDataSourceImpl(
            sharedPreferences: scope.resolve<SharedPreferences>(),
          ),
        )
        .singleton();
  }

  void _bindRepositories(Scope scope) {
    bind<PostsRepository>()
        .toProvide(
          () => PostsRepositoryImpl(
            internetConnectionChecker: scope
                .resolve<InternetConnectionChecker>(),
            remoteDataSource: scope.resolve<PostsRemoteDataSource>(),
            localDataSource: scope.resolve<PostsLocalDataSource>(),
            postMapper: scope.resolve<PostMapper>(),
          ),
        )
        .singleton();
  }

  void _bindUseCases(Scope scope) {
    bind<GetPostsUseCase>()
        .toProvide(
          () => GetPostsUseCase(repository: scope.resolve<PostsRepository>()),
        )
        .singleton();
  }
}
