import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController, numberController;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  final CollectionReference details =
      FirebaseFirestore.instance.collection('details');

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    numberController = TextEditingController();
    collectionReference = firebaseFirestore.collection('details');
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'name cannot Empty';
    }
    return null;
  }

  String? validateNumber(String value) {
    if (value.isEmpty) {
      return 'number cannot Empty';
    }
    return null;
  }

//code firestoreill save cheyan
  Future<void> saveUpadateEmployee(
      String name, String number, String? docId, int aaddEditFlag) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    if (aaddEditFlag == 1) {
      CustomFullScreenDialog.showDialog();
      await collectionReference
          .add({'name': name, 'number': number}).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingController();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: 'Employee added',
            message: "Employee added sucessFully",
            backGround: Colors.green);
      });
      Future.error((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: 'Error',
            message: 'Something went wrong',
            backGround: Colors.red);
      });
    } else if (aaddEditFlag == 2) {
      CustomFullScreenDialog.showDialog();
      await collectionReference
          .add({'name': name, 'number': number}).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingController();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: 'Employee added',
            message: "Employee added sucessFully",
            backGround: Colors.green);
      });
      Future.error((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: 'Error',
            message: 'Something went wrong',
            backGround: Colors.red);
      });
    }
  }

  deleteDialog(String docId) {
    Get.defaultDialog(
      title: 'Delete The data',
      titleStyle: const TextStyle(fontSize: 20),
      middleText: 'Do yu want to delete the data',
      textCancel: 'cancel',
      textConfirm: 'confirm',
      confirmTextColor: Colors.black,
      onCancel: () {},
      onConfirm: () {
        deleteItem(docId);
        Get.back();
      },
    );
  }

  Future<void> deleteItem(String docId) async {
    await details.doc(docId).delete();
  }

  void clearEditingController() {
    nameController.clear();
    numberController.clear();
  }
}
