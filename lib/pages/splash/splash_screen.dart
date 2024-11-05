import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zyra/pages/home/homepage.dart';
import 'package:zyra/pages/login/loginpage.dart';
import 'package:zyra/pages/splash/components/background.dart';
import 'package:zyra/pages/splash/components/floating_gifs.dart';
import 'package:zyra/pages/splash/components/logo.dart';
import 'package:zyra/providers/userProvider.dart';
import 'package:zyra/services/auth_services.dart';
import 'package:zyra/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    print("logginng in");
    authService.getUserData(context);
    print("logged  ");
    Timer(Duration(seconds: 3), () {
      final navigator = Navigator.of(context);
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) =>
                Provider.of<UserProvider>(context).user.id != ""
                    ? HomePage()
                    : LoginPage()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Background(),
          FloatingGifs(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Spacer(flex: 3),
                Logo(),
                Spacer(flex: 1),
                Text(
                  Constants.SplashText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(flex: 3),
                Image(
                  image: AssetImage("assets/gif/loadingbar.gif"),
                  width: MediaQuery.of(context).size.width * (3 / 4),
                ),
                Spacer(flex: 3),
              ],
            ),
          )
        ],
      ),
    );
  }
}
