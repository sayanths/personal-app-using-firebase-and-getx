import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/constants/constants.dart';
import 'package:firebase_app/controllers/auth_controller/auth_controller.dart';
import 'package:firebase_app/controllers/home_controller/home_controller.dart';
import 'package:firebase_app/controllers/image_controller/image_controller.dart';
import 'package:firebase_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 67, 60, 0),
          actions: [
            InkWell(
              onTap: () {
                controller.nameController.clear();
                controller.numberController.clear();
                imageController.img = '';
                _bottomAddEditEmployeeView(
                    text: 'ADD', addEditFlag: 1, docId: '', image: '');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 194, 98, 13),
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
          stream: controller.details.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return InkWell(
                    onTap: () {
                      controller.nameController.text = documentSnapshot['name'];
                      controller.numberController.text =
                          documentSnapshot['number'];
                      imageController.img = documentSnapshot['image'];
                      _bottomAddEditEmployeeView(
                          text: 'UPDATE',
                          addEditFlag: 2,
                          docId: documentSnapshot.id,
                          image: documentSnapshot['image']);
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 250, 243, 181),
                      child: ListTile(
                        leading: Image.memory(const Base64Decoder()
                            .convert(documentSnapshot['image'])),
                        title: Text(documentSnapshot['name']),
                        subtitle: Text(documentSnapshot['number'].toString()),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 255, 17, 0),
                          ),
                          onPressed: () {
                            controller.deleteDialog(documentSnapshot.id);
                          },
                        ),
                      ),
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

  _bottomAddEditEmployeeView(
      {String? image, String? text, int? addEditFlag, String? docId}) {
    Get.bottomSheet(Container(
      color: white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Text(
                  "$text Employee",
                  style: const TextStyle(
                      color: blue, fontSize: 15, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    imageController.pickimage();
                  },
                  child: imageController.img == null
                      ? Stack(
                          children: const [
                            CircleAvatar(
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/login_img.png"),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 20,
                                child: Icon(CupertinoIcons.person_add)),
                          ],
                        )
                      : Stack(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: MemoryImage(const Base64Decoder()
                                  .convert(imageController.img!)),
                            ),
                            const Positioned(
                                bottom: 0,
                                right: 20,
                                child: Icon(CupertinoIcons.person_add)),
                          ],
                        ),
                ),
                CustomTextFormField(
                  hint: 'Name',
                  controller: controller.nameController,
                  icon: Icons.person,
                  validator: (value) {
                    return controller.validateName(value!);
                  },
                ),
                CustomTextFormField(
                  hint: 'number',
                  controller: controller.numberController,
                  icon: Icons.numbers,
                  validator: (value) {
                    return controller.validateNumber(value!);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.saveUpadateEmployee(
                      controller.nameController.text,
                      controller.numberController.text,
                      docId!,
                      addEditFlag!,
                      image = imageController.img,
                    );
                  },
                  //icon: const Icon(CupertinoIcons.person_add),
                  child: Text(addEditFlag == 1 ? 'Add' : 'Update'),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
