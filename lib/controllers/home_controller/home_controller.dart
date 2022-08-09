import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/constants/constants.dart';
import 'package:firebase_app/controllers/auth_controller/auth_controller.dart';
import 'package:firebase_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController, numberController;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  final CollectionReference details =
      FirebaseFirestore.instance.collection(emailName);

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    numberController = TextEditingController();
    collectionReference = firebaseFirestore.collection(emailName);
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
    String name,
    String number,
    String? docId,
    int addEditFlag,
    String? image,
  ) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    if (addEditFlag == 1) {
      CustomFullScreenDialog.showDialog();
      await collectionReference.add({
        'name': name,
        'number': number,
        'image': image,
      }).whenComplete(() {
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
    } else if (addEditFlag == 2) {
      CustomFullScreenDialog.showDialog();
      await collectionReference.doc(docId).update({
        'name': name,
        'number': number,
         'image': image,
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingController();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: 'Employee updated',
            message: "Employee updated sucessFully",
            backGround: Colors.green);
      });
      Future.error((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: 'Error',
            message: 'Something went wrong',
            backGround: const Color.fromARGB(255, 250, 25, 9));
      });
    }
  }

  deleteDialog(String docId) {
    Get.defaultDialog(
      buttonColor: const Color.fromARGB(255, 119, 107, 2),
      title: 'Delete The data',
      titleStyle: const TextStyle(fontSize: 12),
      middleText: 'Do you want to delete the data ?',
      textCancel: 'cancel',
      textConfirm: 'confirm',
      backgroundColor: const Color.fromARGB(255, 186, 164, 162),
      confirmTextColor: white,
      cancelTextColor: white,
      onConfirm: () {
        deleteItem(docId);
        Get.back();
      },
      onCancel: () {},
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
