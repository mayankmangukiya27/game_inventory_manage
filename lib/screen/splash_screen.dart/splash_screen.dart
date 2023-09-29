import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_inventory/controller/auth_controller.dart';
import 'package:game_inventory/screen/dashbaord/dashbaord_screen.dart';
import 'package:game_inventory/screen/login_screen/login_screen.dart';
import 'package:game_inventory/screen/registration_sccreen/registration_sccreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController = Get.put(AuthController());
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      check();
    });
    super.initState();
  }

  check() async {
    final currentUser = await FirebaseAuth.instance.currentUser;

    Get.offAll(() => currentUser?.uid != null ? const CustomBottomBar() : LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f5f1),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.cardImage),
            ),
          ),
        ),
      ),
    );
  }
}
