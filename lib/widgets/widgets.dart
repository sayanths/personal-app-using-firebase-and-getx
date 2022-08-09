import 'package:firebase_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final IconData icon;
  final String? Function(String?)? validator;
  const CustomTextFormField(
      {Key? key,
      required this.hint,
      required this.controller,
      this.obscure = false,
      required this.icon,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: yellow,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: yellow,
            ),
          ),
        ),
        obscureText: obscure,
      ),
    );
  }
}

class CustomFullScreenDialog {
  static showDialog() {
    Get.dialog(
      WillPopScope(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: Colors.blue.withOpacity(.3),
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    Get.back();
  }
}

class CustomSnackBar {
  static void showSnackBar({
    required BuildContext? context,
    required String title,
    required String message,
    required Color backGround,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: white,
      titleText: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      messageText: Text(message),
    );
  }
}
