import 'package:cherrypick/cherrypick.dart';
import 'package:posts_app/common/data/datasource/theme_local_data_source.dart';
import 'package:posts_app/common/domain/usecase/get_theme_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repositories/theme_repository_impl.dart';
import '../domain/repositories/theme_repository.dart';
import '../domain/usecase/set_theme_usecase.dart';

class CommonDiModule extends Module {
  @override
  void builder(Scope currentScope) {
    _bindDataSources(currentScope);
    _bindRepositories(currentScope);
    _bindUseCases(currentScope);
  }

  _bindDataSources(Scope scope) {
    bind<ThemeLocalDataSource>().toProvide(
      () => ThemeLocalDataSourceImpl(
        sharedPreferences: scope.resolve<SharedPreferences>(),
      ),
    );
  }

  _bindRepositories(Scope scope) {
    bind<ThemeRepository>().toProvide(
      () => ThemeRepositoryImpl(
        themeLocalDataSource: scope.resolve<ThemeLocalDataSource>(),
      ),
    );
  }

  _bindUseCases(Scope scope) {
    bind<SetThemeUseCase>().toProvide(
      () => SetThemeUseCase(repository: scope.resolve<ThemeRepository>()),
    );

    bind<GetThemeUseCase>().toProvide(
      () => GetThemeUseCase(repository: scope.resolve<ThemeRepository>()),
    );
  }
}
