import 'package:firebase_app/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        actions: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: CircleAvatar(
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  AuthController.instance.logout();
                },
                child: const Text("logout"))
          ],
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(Icons.add),
            title: const Text("main"),
            subtitle: const Text("sub title"),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
