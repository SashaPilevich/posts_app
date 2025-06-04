import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../error/failures.dart';

/// An abstract class representing a future use case in the domain layer.
abstract class FutureUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// A class representing no parameters.
/// This used when a use case does not require any input parameters.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
