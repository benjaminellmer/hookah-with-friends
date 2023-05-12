import "dart:io";

import "package:firebase_database/firebase_database.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/cupertino.dart";
import "package:image_cropper/image_cropper.dart";
import "package:image_picker/image_picker.dart";

import "../util/colors.dart";
import "user_service.dart";

class ImageService {
  final ImagePicker picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  Future<dynamic> pickGalleryImage(BuildContext context) async {
    final XFile? pickerFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if(pickerFile != null) {
      _image = XFile(pickerFile.path);
      cropSquareImage();
    }
  }

  Future<dynamic> pickCameraImage(BuildContext context) async {
    final XFile? pickerFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if(pickerFile != null) {
      _image = XFile(pickerFile.path);
      cropSquareImage();
    }
  }

  Future<dynamic> cropSquareImage() async {
    if(_image != null) {
      await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Crop image",
            backgroundColor: HWFColors.background,
            toolbarColor: HWFColors.background,
            toolbarWidgetColor: HWFColors.orange,
          ),
          IOSUiSettings(
            title: "Crop image",
          )
        ]
      );
    }
  }

  void uploadImage() async {
    UserService userService = UserService();
    DatabaseReference db_ref = FirebaseDatabase.instance.ref().child("user");
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storage_ref = FirebaseStorage.instance.ref("/profileImage-${userService.uid}");

    UploadTask uploadTask = storage_ref.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storage_ref.getDownloadURL();
    

  }

}
