import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}

Future<XFile?> pickImageFromGallery(BuildContext context) async {
  XFile? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = pickedImage;
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}