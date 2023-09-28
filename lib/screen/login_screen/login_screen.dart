import 'package:flutter/material.dart';
import 'package:game_inventory/constants/app_colors.dart';
import 'package:game_inventory/constants/images.dart';
import 'package:game_inventory/controller/auth_controller.dart';
import 'package:game_inventory/screen/registration_sccreen/registration_sccreen.dart';
import 'package:game_inventory/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final con = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 165,
                  width: 165,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.cardImage),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Login',
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(height: 45),
            CustomTextField(
              controller: con.emailTc,
              hint: 'Email',
            ),
            const SizedBox(height: 25),
            CustomTextField(
              controller: con.passwordTc,
              hint: 'Password',
            ),
            const SizedBox(height: 35),
            InkWell(
              onTap: () => con.login(),
              child: Container(
                width: 165,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.white),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => Get.to(() => RegistrationScreen()),
              child: RichText(
                  text: const TextSpan(text: "Don't have account? ", style: TextStyle(color: Colors.grey), children: [
                TextSpan(
                  text: "Register",
                  style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w500),
                )
              ])),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
