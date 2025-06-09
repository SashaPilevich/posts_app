import 'package:cherrypick/cherrypick.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/features/post_details/data/api_service/post_details_api_service.dart';
import 'package:posts_app/features/post_details/data/datasource/remote/post_details_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/data/mapper/post_mapper.dart';
import '../../../network/dio_client.dart';
import '../data/datasource/local/post_details_local_data_source.dart';
import '../data/datasource/local/post_details_local_data_source_impl.dart';
import '../data/datasource/remote/post_details_remote_data_source_impl.dart';
import '../data/repository/post_details_repository_impl.dart';
import '../domain/repository/post_details_repository.dart';
import '../domain/usecase/get_post_details_usecase.dart';

class PostDetailsDiModule extends Module {
  @override
  void builder(Scope currentScope) {
    _bindMappers(currentScope);
    _bindApiService(currentScope);
    _bindDataSources(currentScope);
    _bindRepositories(currentScope);
    _bindUseCases(currentScope);
  }

  void _bindMappers(Scope scope) {
    bind<PostMapper>().toProvide(() => PostMapper());
  }

  void _bindApiService(Scope scope) {
    bind<PostDetailsApiService>().toProvide(
      () => PostDetailsApiService(scope.resolve<DioClient>().dio),
    );
  }

  void _bindDataSources(Scope scope) {
    bind<PostDetailsRemoteDataSource>().toProvide(
      () => PostDetailsRemoteDataSourceImpl(
        postDetailsApiService: scope.resolve<PostDetailsApiService>(),
      ),
    );

    bind<PostDetailsLocalDataSource>().toProvide(
      () => PostDetailsLocalDataSourceImpl(sharedPreferences: scope.resolve<SharedPreferences>()),
    );
  }

  void _bindRepositories(Scope scope) {
    bind<PostDetailsRepository>().toProvide(
      () => PostDetailsRepositoryImpl(
        internetConnectionChecker: scope.resolve<InternetConnectionChecker>(),
        remoteDataSource: scope.resolve<PostDetailsRemoteDataSource>(),
        localDataSource: scope.resolve<PostDetailsLocalDataSource>(),
        postMapper: scope.resolve<PostMapper>(),
      ),
    );
  }

  void _bindUseCases(Scope scope) {
    bind<GetPostDetailsUseCase>().toProvide(
      () => GetPostDetailsUseCase(repository: scope.resolve<PostDetailsRepository>()),
    );
  }
}
