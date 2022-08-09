import 'package:firebase_app/constants/constants.dart';
import 'package:firebase_app/controllers/auth_controller/auth_controller.dart';
import 'package:firebase_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final emailName = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
      height: height,
      width: width,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: height / 3.5,
            width: 100,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 249, 17, 0),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(150))),
            child: const Center(
                child: Text(
              "Create an aaccount now",
              style: TextStyle(
                  color: white, fontSize: 25, fontWeight: FontWeight.bold),
            )),
          ),
          const SizedBox(
            height: 60,
          ),
          CustomTextFormField(
            controller: emailName,
            hint: 'Email',
            icon: Icons.email,
            // validator: (p0) {
            //   (p0 == null) ? 'enter email' : null;
            // },
          ),
          kHeight,
          CustomTextFormField(
            controller: password,
            hint: 'Password',
            icon: Icons.password_outlined,
            obscure: true,
            //  validator: (p1) {
            //   (p1 == null) ? 'enter email' : null;
            // },
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 0, 32, 57)),
                  onPressed: () {
                    AuthController.instance
                        .register(emailName.text.trim(), password.text.trim());
                  },
                  icon: const Icon(Icons.signpost_outlined),
                  label: const Text("Sign up"))),
                    const SizedBox(
            height: 30,
          ),
          Container(
            height: height / 1,
            width: width,
            decoration: const BoxDecoration(

                color: Color.fromARGB(255, 71, 7, 3),
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(150))),
                   child: Image.asset("assets/smile.png",),
          ),
        ],
      ),
    ));
  }
}
