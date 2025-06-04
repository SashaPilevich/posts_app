import 'package:equatable/equatable.dart';

/// Base class for all application failures.
/// Represents expected error states that must be handled by presentation layer.
abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const []]);

  @override
  List<Object?> get props => [properties];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
