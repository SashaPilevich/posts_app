import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

/// An abstract class representing a future use case in the domain layer.
abstract class FutureUseCase<Input, Output> {
  Future<Either<Failure, Output>> execute(Input input);
}

/// A class representing no parameters.
/// This used when a use case does not require any input parameters.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
