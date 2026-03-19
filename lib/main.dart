import 'package:expense_project/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_project/core/services/database_service.dart';
import 'package:expense_project/core/theme/app_theme.dart';
import 'package:expense_project/app/app_router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService().init();

  runApp(const ProviderScope(child: NoteGoApp()));
}

class NoteGoApp extends ConsumerWidget {
  const NoteGoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);

    return themeAsync.when(
      loading: () {
        return const SizedBox.shrink();
      },
      error: (error, stack) {
        return MaterialApp(
          home: Scaffold(body: Center(child: Text('Theme load error: $error'))),
        );
      },
      data: (isDarkMode) {
        return MaterialApp.router(
          title: 'Note-Go Expense Tracker',
          debugShowCheckedModeBanner: false,

          routerConfig: router,

          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
