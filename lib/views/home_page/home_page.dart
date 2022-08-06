import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _details =
      FirebaseFirestore.instance.collection('details');
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
        body: StreamBuilder(
          stream: _details.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return ListTile(
                    leading: const Icon(Icons.add),
                    title:  Text(documentSnapshot['name']),
                    subtitle:  Text(documentSnapshot['number'].toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
