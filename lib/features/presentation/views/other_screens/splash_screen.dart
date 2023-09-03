import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/features/presentation/views/other_screens/choose_category.dart';
import 'package:news_app/features/presentation/views/other_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double iconWidth = 300;
  bool showMessage = false;
  bool start = false;
  Timer? _timer;
  _goNext() {
    FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        if (user == null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginView()));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ChooseCategoryScreen()));
        }
      },
    );
  }

  @override
  void initState() {
    // showMessage = true;
    super.initState();
    Future.delayed(const Duration(microseconds: 1), () {
      setState(() {});
      showMessage = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 2000),
            top: showMessage
                ? MediaQuery.of(context).size.height * 0.6
                : MediaQuery.of(context).size.height * 0.35,
            right: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              children: [
                Text(
                  "Ai Viral News",
                  style: GoogleFonts.lobster(
                    fontWeight: FontWeight.bold,
                    fontSize: 54,
                    color: const Color.fromARGB(255, 7, 48, 214),
                  ),
                ),
                const Text(
                  "News App",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    color: Color.fromARGB(255, 94, 180, 251),
                  ),
                ),
              ],
            ),
            onEnd: () {
              start = true;
              setState(() {});
            },
          ),
          AnimatedPositioned(
            right: MediaQuery.of(context).size.width * 0.17,
            // curve: Curves.bounceInOut,
            width: start ? 200 : 300,
            top: MediaQuery.of(context).size.width * 0.5,
            duration: const Duration(milliseconds: 1000),
            child: Image.asset(
              'assets/images/akhbary-logo.png',
            ),
            onEnd: () => _goNext(),
          ),
        ],
      ),
    );
  }
}
