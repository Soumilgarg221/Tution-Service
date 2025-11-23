import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const TuitionApp());
}

class TuitionApp extends StatefulWidget {
  const TuitionApp({super.key});

  @override
  State<TuitionApp> createState() => _TuitionAppState();
}

class _TuitionAppState extends State<TuitionApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      home: HomePage(
        toggleTheme: () {
          setState(() {
            isDark = !isDark;
          });
        },
      ),
    );
  }
}

/// LIGHT THEME
final ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF1565C0),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1565C0),
    foregroundColor: Colors.white,
  ),

  /// 🔵 Classic curved buttons (only left-right curved)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xFF1565C0)),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      minimumSize: WidgetStatePropertyAll(Size(100, 38)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
        ),
      ),
    ),
  ),
);

/// DARK THEME
final ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF1565C0),
  scaffoldBackgroundColor: const Color(0xFF0D1117),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1565C0),
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xFF1565C0)),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      minimumSize: WidgetStatePropertyAll(Size(100, 38)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
        ),
      ),
    ),
  ),
);
