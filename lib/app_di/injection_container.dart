import 'package:cherrypick/cherrypick.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/features/posts_list/di/posts_di.dart';

import '../network/dio_client.dart';

class DIContainer {
  static Scope get scope => _scope;

  static late final Scope _scope;

  static Future<void> init() async {
    _scope = openRootScope().installModules([
      ExternalModule(),
      DioClientModule(),
      PostsDiModule(),
    ]);
  }
}

class DioClientModule extends Module {
  @override
  void builder(Scope currentScope) {
    bind<DioClient>().toProvide(
      () => DioClient(baseUrl: 'https://jsonplaceholder.typicode.com/'),
    );
  }
}

class ExternalModule extends Module {
  @override
  void builder(Scope currentScope) {
    bind<InternetConnectionChecker>().toProvide(
      () => InternetConnectionChecker.instance,
    );
  }
}
