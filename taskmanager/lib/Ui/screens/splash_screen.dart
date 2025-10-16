import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:taskmanager/Ui/controller/auth_controller.dart';
import 'package:taskmanager/Ui/screens/bottom_nav_bar.dart';
import 'package:taskmanager/Ui/screens/login.dart';
import 'package:taskmanager/Ui/utils/asset_paths.dart';
import 'package:taskmanager/Ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    final bool isLoggedIn = await AuthController.isUserAlreadyLoggedIn();
    if (isLoggedIn) {
      await AuthController.getUserData();
      Navigator.pushReplacementNamed(context, MainNavBarHolderScreen.name);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: SvgPicture.asset(AssetPaths.logoSvg, height: 40)),
      ),
    );
  }
}
