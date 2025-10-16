import 'package:flutter/material.dart';
import 'package:taskmanager/Ui/screens/bottom_nav_bar.dart';
import 'package:taskmanager/Ui/screens/login.dart';
import 'package:taskmanager/Ui/screens/profile_update_screen.dart';
import 'package:taskmanager/Ui/screens/signup_screen.dart';
import 'package:taskmanager/Ui/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialRoute: SplashScreen.name,
      routes: {
        SplashScreen.name: (_) => SplashScreen(),
        LoginScreen.name: (_) => LoginScreen(),
        SignUpScreen.name: (_) => SignUpScreen(),
        MainNavBarHolderScreen.name: (_) => MainNavBarHolderScreen(),
        ProfileUpdateScreen.name: (_) => ProfileUpdateScreen(),
      },
    );
  }
}
