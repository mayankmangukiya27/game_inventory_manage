import 'package:flutter/material.dart';
import 'package:game_inventory/constants/app_colors.dart';
import 'package:game_inventory/constants/images.dart';
import 'package:game_inventory/controller/auth_controller.dart';
import 'package:game_inventory/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final con = Get.put(AuthController());

  @override
  void dispose() {
    con.emailTc.clear();
    con.nameTc.clear();
    con.passwordTc.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              'Registration',
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(height: 45),
            CustomTextField(
              hint: 'Name',
              controller: con.nameTc,
            ),
            const SizedBox(height: 25),
            CustomTextField(
              hint: 'Email',
              controller: con.emailTc,
            ),
            const SizedBox(height: 25),
            CustomTextField(
              hint: 'Password',
              controller: con.passwordTc,
            ),
            const SizedBox(height: 35),
            InkWell(
              onTap: () => con.register(),
              child: Container(
                width: 165,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  'Registration',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
