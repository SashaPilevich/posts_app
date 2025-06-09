import 'package:dartz/dartz.dart';
import 'package:posts_app/common/data/datasource/theme_local_data_source.dart';
import 'package:posts_app/common/domain/entities/app_theme.dart';
import 'package:posts_app/common/domain/repositories/theme_repository.dart';
import 'package:posts_app/core/error/exception.dart';
import 'package:posts_app/core/error/failures.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource _themeLocalDataSource;

  ThemeRepositoryImpl({required ThemeLocalDataSource themeLocalDataSource})
    : _themeLocalDataSource = themeLocalDataSource;

  @override
  Future<Either<Failure, AppTheme>> getTheme() async {
    try {
      final AppTheme theme = await _themeLocalDataSource.fetchTheme();
      return Right(theme);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setTheme(AppTheme theme) async {
    try {
      await _themeLocalDataSource.setTheme(theme);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
