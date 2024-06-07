import 'package:chat_app_2/utils/helper/auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isRight=AuthHelper.helper.checkUser();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),() => Get.offAllNamed( isRight?'home':'signin'),);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Center(
          child: Lottie.asset(
          'assets/json/Animation .json',

          fit: BoxFit.cover,
          ),
        ),
        ],
      ),
    );
  }
}
