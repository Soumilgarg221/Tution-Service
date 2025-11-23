import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Default: Light mode first
  ThemeMode _themeMode = ThemeMode.light;

  // Toggle Function
  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tuition Services",
      debugShowCheckedModeBanner: false,

      // Global Theme Control
      themeMode: _themeMode,

      // Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
          elevation: 3,
        ),
      ),

      // Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0E1A2A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
          elevation: 3,
        ),
      ),

      // Pass theme toggle into HomePage
      home: HomePageWithTheme(toggleTheme: _toggleTheme),
    );
  }
}

// Wrapper to pass toggleTheme to HomePage
class HomePageWithTheme extends StatelessWidget {
  final VoidCallback toggleTheme;
  const HomePageWithTheme({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return HomePage(toggleTheme: toggleTheme);
  }
}
