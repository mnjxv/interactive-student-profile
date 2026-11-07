import 'package:flutter/material.dart';

import 'app_state.dart';
import 'screens/main_shell.dart';

void main() {
  runApp(const StudentProfileApp());
}

class StudentProfileApp extends StatefulWidget {
  const StudentProfileApp({super.key});

  @override
  State<StudentProfileApp> createState() => _StudentProfileAppState();
}

class _StudentProfileAppState extends State<StudentProfileApp> {
  final AppState _state = AppState();

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  ThemeData _theme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _state.seedColor,
      brightness: brightness,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _state,
      // Rebuild the MaterialApp whenever the theme settings change.
      child: ListenableBuilder(
        listenable: _state,
        builder: (context, _) {
          return MaterialApp(
            title: 'Interactive Student Profile',
            debugShowCheckedModeBanner: false,
            theme: _theme(Brightness.light),
            darkTheme: _theme(Brightness.dark),
            themeMode: _state.themeMode,
            home: const MainShell(),
          );
        },
      ),
    );
  }
}
