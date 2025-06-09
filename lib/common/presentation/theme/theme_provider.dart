import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/common/domain/usecase/get_theme_usecase.dart';
import 'package:posts_app/common/domain/usecase/set_theme_usecase.dart';
import 'package:posts_app/core/usecase/usecase.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/app_theme.dart';

class ThemeProvider with ChangeNotifier {
  final GetThemeUseCase _getThemeUseCase;
  final SetThemeUseCase _setThemeUseCase;

  ThemeProvider({
    required GetThemeUseCase getThemeUseCase,
    required SetThemeUseCase setThemeUseCase,
  }) : _getThemeUseCase = getThemeUseCase,
       _setThemeUseCase = setThemeUseCase {
    _getTheme();
  }

  ThemeMode? _themeMode;

  ThemeMode? get themeMode => _themeMode;

  Future<void> _getTheme() async {
    final Either<Failure, AppTheme> theme = await _getThemeUseCase.execute(
      NoParams(),
    );
    theme.fold(
      (failure) {
        return _themeMode = ThemeMode.dark;
      },
      (theme) {
        _setThemeMode(theme);
      },
    );
    notifyListeners();
  }

  void setTheme(AppTheme theme) {
    _setThemeMode(theme);
    _setThemeUseCase.execute(theme);
    notifyListeners();
  }

  void _setThemeMode(AppTheme theme) {
    _themeMode = theme == AppTheme.light ? ThemeMode.light : ThemeMode.dark;
  }
}
