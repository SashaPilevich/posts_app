import 'package:flutter/material.dart';
import 'package:posts_app/common/domain/usecase/get_theme_usecase.dart';
import 'package:posts_app/common/domain/usecase/set_theme_usecase.dart';
import 'package:provider/provider.dart';

import 'app_di/di_container.dart';
import 'common/domain/entities/app_theme.dart';
import 'common/presentation/theme/theme_provider.dart';
import 'navigation/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DIContainer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(
        getThemeUseCase: DIContainer.scope.resolve<GetThemeUseCase>(),
        setThemeUseCase: DIContainer.scope.resolve<SetThemeUseCase>(),
      ),
      child: Consumer<ThemeProvider>(
        builder:
            (BuildContext context, ThemeProvider themeProvider, Widget? child) {
              final ThemeMode? themeMode = themeProvider.themeMode;
              return MaterialApp.router(
                routerConfig: DIContainer.scope.resolve<AppRouter>().config(),
                title: 'Posts Test',
                theme: themeMode?.name == AppTheme.dark.name
                    ? ThemeData.dark()
                    : ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: themeMode,
              );
            },
      ),
    );
  }
}
