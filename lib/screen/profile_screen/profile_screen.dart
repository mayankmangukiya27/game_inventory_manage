import 'package:flutter/material.dart';
import 'package:game_inventory/constants/app_colors.dart';
import 'package:game_inventory/controller/auth_controller.dart';
import 'package:game_inventory/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () => authController.logOut(),
            icon: const Icon(
              Icons.logout,
              size: 30,
              color: AppColors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            CustomTextField(
              hint: 'Name',
            ),
            const SizedBox(height: 25),
            CustomTextField(
              hint: 'Email',
            ),
            // const SizedBox(height: 35),
            // InkWell(
            //   // onTap: () => con.login(),
            //   child: Container(
            //     width: 165,
            //     alignment: Alignment.center,
            //     padding: const EdgeInsets.symmetric(vertical: 15),
            //     decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(30)),
            //     child: Text(
            //       'Save',
            //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.white),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
