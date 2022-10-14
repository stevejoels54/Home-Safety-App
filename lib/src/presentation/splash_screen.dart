import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import '../presentation/login_screen.dart';
import '../presentation/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/images/fire-sensor.png'),
          Text(
            'Home Safety System',
            style: GoogleFonts.nunitoSans(
              fontSize: 25,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      nextScreen: const HomeScreen(),
      splashIconSize: 200,
      splashTransition: SplashTransition.slideTransition,
      duration: 4000,
    );
  }
}
