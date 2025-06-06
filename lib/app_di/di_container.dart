import 'package:cherrypick/cherrypick.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/constants/api_constants.dart';
import 'package:posts_app/features/posts_list/di/posts_di.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation/app_router.dart';
import '../network/dio_client.dart';

class DIContainer {
  static Scope get scope => _scope;

  static late final Scope _scope;

  static Future<void> init() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _scope = openRootScope().installModules([
      AppRouterModule(),
      ExternalModule(sharedPreferences: sharedPreferences),
      DioClientModule(),
      PostsDiModule(),
    ]);
  }
}

class AppRouterModule extends Module {
  @override
  void builder(Scope currentScope) {
    bind<AppRouter>().toInstance(AppRouter());
  }
}

class DioClientModule extends Module {
  @override
  void builder(Scope currentScope) {
    bind<DioClient>().toInstance(DioClient(baseUrl: ApiConstants.baseUrl));
  }
}

class ExternalModule extends Module {
  final SharedPreferences sharedPreferences;

  ExternalModule({required this.sharedPreferences});

  @override
  void builder(Scope currentScope) {
    bind<InternetConnectionChecker>().toInstance(
      InternetConnectionChecker.instance,
    );
    bind<SharedPreferences>().toInstance(sharedPreferences);
  }
}
