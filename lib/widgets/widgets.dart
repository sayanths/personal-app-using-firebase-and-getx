import 'package:firebase_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  final bool obscure;
  final IconData icon;
  String? Function(String?)? validator;
  CustomTextFormField(
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
