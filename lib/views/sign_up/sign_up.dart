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
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 300,
            width: 100,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 249, 17, 0),
            ),
          ),
          kHeight,
          kHeight,
          kHeight,
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
          Center(
              child: ElevatedButton.icon(
                  onPressed: () {
                    AuthController.instance
                        .register(emailName.text.trim(), password.text.trim());
                  },
                  icon: const Icon(Icons.signpost_outlined),
                  label: const Text("Sign up")))
        ],
      ),
    ));
  }
}
