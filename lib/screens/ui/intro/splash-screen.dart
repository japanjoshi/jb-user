import 'package:flutter/material.dart';

import 'package:jb_user_app/screens/tab_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'welcome_screen.dart';
// import 'package:jb_user_app/screens/main_screen.dart'; // Replace with your actual main screen
// import 'package:jb_user_app/screens/welcome_screen.dart'; // Replace with your login screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(
        seconds: 1,
      ),
      () async {
        await checkAuthStatus();
      },
    );
  }

  /// Checks the current authentication status and navigates accordingly
  Future checkAuthStatus() async {
    final supabaseClient = Supabase.instance.client;
    final currentUser = supabaseClient.auth.currentUser;

    if (currentUser != null) {
      print("user not null");
      // User is already authenticated, navigate to main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TabBarPage(), // Update with your main screen widget
        ),
      );
    } else {
      // No authenticated user found, navigate to the welcome/login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const WelcomeScreen(), // Update with your login screen widget
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // A simple loading indicator
      ),
    );
  }
}
