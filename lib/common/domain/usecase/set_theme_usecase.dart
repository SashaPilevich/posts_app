import 'package:dartz/dartz.dart';
import 'package:posts_app/common/domain/repositories/theme_repository.dart';
import 'package:posts_app/core/usecase/usecase.dart';

import '../../../core/error/failures.dart';
import '../entities/app_theme.dart';

class SetThemeUseCase implements FutureUseCase<AppTheme, void> {
  final ThemeRepository _repository;

  SetThemeUseCase({required ThemeRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, void>> execute(AppTheme theme) async {
    return _repository.setTheme(theme);
  }
}
