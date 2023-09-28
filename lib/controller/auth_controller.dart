import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_inventory/screen/dashbaord/dashbaord_screen.dart';
import 'package:game_inventory/screen/login_screen/login_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final emailTc = TextEditingController();
  final passwordTc = TextEditingController();
  final nameTc = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  login() async {
    final pref = await SharedPreferences.getInstance();

    if (emailTc.text.isEmpty || passwordTc.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        isDismissible: true,
        message: "Please enter Email and Password",
        duration: Duration(seconds: 3),
      ));
    } else {
      if (!emailTc.text.isEmail) {
        Get.showSnackbar(const GetSnackBar(
          isDismissible: true,
          message: "Please enter valid email",
          duration: Duration(seconds: 3),
        ));
      } else if (passwordTc.text.length < 8) {
        Get.showSnackbar(const GetSnackBar(
          isDismissible: true,
          message: "Password must be 8 character",
          duration: Duration(seconds: 3),
        ));
      } else {
        try {
          final UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailTc.text, password: passwordTc.text);
          if (credential.user != null) {
            pref.setString('userId', credential.user!.uid);

            Get.to(() => CustomBottomBar());
          }
        } on FirebaseAuthException catch (e) {
          Get.showSnackbar(GetSnackBar(
            isDismissible: true,
            message: "$e",
            duration: const Duration(seconds: 3),
          ));
        }
      }
    }
  }

  register() async {
    final pref = await SharedPreferences.getInstance();
    if (emailTc.text.isEmpty || passwordTc.text.isEmpty || nameTc.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        isDismissible: true,
        message: "Please enter all filed",
        duration: Duration(seconds: 3),
      ));
    } else {
      if (!emailTc.text.isEmail) {
        Get.showSnackbar(const GetSnackBar(
          isDismissible: true,
          message: "Please enter valid email",
          duration: Duration(seconds: 3),
        ));
      } else if (passwordTc.text.length < 8) {
        Get.showSnackbar(const GetSnackBar(
          isDismissible: true,
          message: "Password must be 8 character",
          duration: Duration(seconds: 3),
        ));
      } else {
        try {
          final UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailTc.text,
            password: passwordTc.text,
          );

          if (credential.user != null) {
            addUser(credential.user!);
            pref.setString('userId', credential.user!.uid);
            Get.to(() => CustomBottomBar());
          }
        } on FirebaseAuthException catch (e) {
          Get.showSnackbar(GetSnackBar(
            isDismissible: true,
            message: "$e",
            duration: const Duration(seconds: 3),
          ));
        } catch (e) {
          print(e);
        }
      }
    }
  }

  logOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Get.offAll(() => LoginScreen());
  }

  addUser(User user) async {
    users
        .doc(user.uid)
        .set({'full_name': nameTc.text, 'email': user.email, 'id': user.uid})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
