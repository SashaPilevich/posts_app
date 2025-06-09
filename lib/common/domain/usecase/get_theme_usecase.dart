import 'package:dartz/dartz.dart';
import 'package:posts_app/common/domain/repositories/theme_repository.dart';
import 'package:posts_app/core/usecase/usecase.dart';

import '../../../core/error/failures.dart';
import '../entities/app_theme.dart';

class GetThemeUseCase implements FutureUseCase<NoParams, AppTheme> {
  final ThemeRepository _repository;

  GetThemeUseCase({required ThemeRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, AppTheme>> execute(NoParams input) async {
    return _repository.getTheme();
  }
}
