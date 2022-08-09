import 'dart:ui';

import 'package:firebase_app/constants/constants.dart';
import 'package:firebase_app/controllers/auth_controller/auth_controller.dart';
import 'package:firebase_app/views/sign_up/sign_up.dart';
import 'package:firebase_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 8.0),
          child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  // repeat: ImageRepeat.noRepeat,
                  image: AssetImage(
                    "assets/inntro.jpg",
                  ),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: height / 3,
                        width: width / 1.1,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              kHeight,
                              CustomTextFormField(
                                controller: emailController,
                                hint: 'Email',
                                icon: Icons.email,
                              ),
                              CustomTextFormField(
                                controller: passwordController,
                                hint: 'password',
                                icon: Icons.password,
                                obscure: true,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  AuthController.instance.login(
                                      emailController.text,
                                      passwordController.text.trim());
                                },
                                child: const Text("Log in"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't you have an acccount?"),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(() => SignUpPage());
                                      },
                                      child: const Text("Sign up"))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
