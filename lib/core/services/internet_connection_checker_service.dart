import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetConnectionCheckerService {
  Future<bool> get isConnected;
}

class InternetConnectionCheckerServiceImpl
    implements InternetConnectionCheckerService {
  final InternetConnectionChecker _internetConnectionChecker;

  InternetConnectionCheckerServiceImpl(this._internetConnectionChecker);

  @override
  Future<bool> get isConnected async {
    return await _internetConnectionChecker.hasConnection;
  }
}
