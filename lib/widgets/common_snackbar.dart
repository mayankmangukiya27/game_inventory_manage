import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFunction {
  static void showSnackBar({
    required String title,
    required String message,
    SnackPosition? snackPosition,
  }) {
    Get.snackbar(
      title, message,
      snackPosition: snackPosition ?? SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      borderRadius: 8,
      // titleText: Text(
      //   title,
      //   style: TextStyle(
      //     color: title.toLowerCase().contains('success') ? Colors.green : Colors.red,
      //     fontWeight: FontWeight.bold,
      //     fontSize: 18,
      //   ),
      // ),
      // messageText: Text(
      //   message,
      //   style: TextStyle(
      //     color: title.toLowerCase().contains('success') ? Colors.green : Colors.red,
      //     fontWeight: FontWeight.bold,
      //     fontSize: 15,
      //   ),
      // ),
      backgroundColor: title.toLowerCase().contains('success') ? Colors.green : Colors.red,
      // : title.toLowerCase().contains('error')
      //     ? Colors.red
      //     : Colors.black45,
      animationDuration: const Duration(milliseconds: 500),
      barBlur: 10,

      // colorText: title.toLowerCase().contains('success') ? Colors.green : Colors.red,
      colorText: Colors.white,
      isDismissible: false,
    );
  }
}
