import 'package:dartz/dartz.dart';
import 'package:posts_app/common/domain/entities/app_theme.dart';

import '../../../core/error/failures.dart';

abstract class ThemeRepository {
  Future<Either<Failure, AppTheme>> getTheme();

  Future<Either<Failure, void>> setTheme(AppTheme theme);
}
