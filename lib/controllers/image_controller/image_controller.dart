import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  String? img = '';
  pickimage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      return;
    } else {
      final bytes = File(pickedImage.path).readAsBytesSync();
      img = base64Encode(bytes);
      update();
    }

    // imageCache.clear();
  }
}
