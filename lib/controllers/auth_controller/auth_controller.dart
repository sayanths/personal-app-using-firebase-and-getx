import 'package:firebase_app/views/home_page/home_page.dart';
import 'package:firebase_app/views/login_page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance =
      Get.find(); //creating an instance for auth controller

  late Rx<User?> _user; //for firebase name email okke kitan
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth
        .authStateChanges()); //login logout all this operations will be notified becoz of this streambinding
    ever(_user, initialScreen);
  }

  initialScreen(User? user) {
    user == null
        ? Get.offAll(() => LoginPage())
        : Get.offAll(() =>  HomePage());
  }

  void register(email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(" user", "login failed",
          // backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text("Acount  creation failed"),
          messageText: Text(e.toString()));
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        " About Login", "Please enter a valid id",
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        snackPosition: SnackPosition.TOP,
        titleText: const Text("Login failed"),
        //  messageText: Text("Login failed")
      );
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
