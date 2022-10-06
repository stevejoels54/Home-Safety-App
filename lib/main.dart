import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/presentation/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      title: 'Home Safety App',
      home: const SplashScreen(),
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.nunitoSansTextTheme(baseTheme.textTheme),
  );
}
