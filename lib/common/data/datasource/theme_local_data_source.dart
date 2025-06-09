import 'package:posts_app/common/domain/entities/app_theme.dart';
import 'package:posts_app/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  Future<AppTheme> fetchTheme();

  Future<void> setTheme(AppTheme theme);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences _sharedPreferences;

  final String _themeKey = 'theme';

  ThemeLocalDataSourceImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<AppTheme> fetchTheme() async {
    final String? cachedTheme = _sharedPreferences.getString(_themeKey);
    if (cachedTheme != null) {
      return AppTheme.values.firstWhere((theme) => theme.name == cachedTheme);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> setTheme(AppTheme theme) async {
    try {
      _sharedPreferences.setString(_themeKey, theme.name);
    } catch (_) {
      throw CacheException();
    }
  }
}
