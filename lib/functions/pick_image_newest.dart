import 'package:by_your_way/services/custom_navigation_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../constants/my_colors.dart';
import '../widget/custom_text.dart';

Future<File?> cameraImagePicker(BuildContext context, ) async {
  return showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
              onPressed: () async {
                File? image;
                image = await pickImage(false);
                print('image--2--$image');
                if (image != null) {
                  // if (isUserProfile) {
                  //   profile_image = image;
                  // } else {
                  //   pet_image = image;
                  // }
                  Navigator.pop(context, image);
                }
                // popPage(context: ctx);
              },
              child: const SubHeadingText(
                'Take a picture',
                color: MyColors.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )),
          CupertinoActionSheetAction(
              onPressed: () async {
                File? image;
                image = await pickImage(true, prefferedCameraDevice: CameraDevice.front);
                print('image--4--$image');
                // if (image != null) {
                //   profile_image = image;
                //   notifyListeners();
                // }
                Navigator.pop(context, image);
                // popPage(context: ctx, image);
              },
              child: const SubHeadingText(
                'Gallery',
                color: MyColors.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )),
        ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => CustomNavigation.pop(context),
            child: const SubHeadingText(
              'Close',
              color: MyColors.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
      ));
}



Future<File?> pickImage(bool isGallery, {CameraDevice prefferedCameraDevice = CameraDevice.rear}) async {
  final ImagePicker picker = ImagePicker();

  File? image;
  String? _imageFile;
  try {
    int imageQualityPercent = 80;
    print('about to pick image with image quality $imageQualityPercent');
    XFile? pickedFile;
    if (isGallery) {
      pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: imageQualityPercent,
          maxHeight: 600);
    } else {
      pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: imageQualityPercent,
          preferredCameraDevice: prefferedCameraDevice,
          maxHeight: 600);
    }
    print('the error is $pickedFile');
    int length = await pickedFile!.length();
    print('the length is');
    // print('size : ${length}');
    print('size: ${await pickedFile.readAsBytes()}');
    File? croppedFile = await ImageCropper().cropImage(
      cropStyle: CropStyle.circle,
      // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: length > 100000
          ? length > 200000
          ? length > 300000
          ? length > 400000
          ? 5
          : 10
          : 20
          : 30
          : 50,
      sourcePath: pickedFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        // CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
      ],
      // androidUiSettings: const AndroidUiSettings(
      //     activeControlsWidgetColor: MyColors.primaryColor,
      //     toolbarTitle: 'Adjust your Post',
      //     toolbarColor: MyColors.primaryColor,
      //     toolbarWidgetColor: MyColors.blackColor,
      //     initAspectRatio: CropAspectRatioPreset.original,
      //     lockAspectRatio: true),
      // iosUiSettings: const IOSUiSettings(
      //   minimumAspectRatio: 1.0,
      // )
    );

    _imageFile = croppedFile!.path;
    image = File(croppedFile.path);
    print(croppedFile);
    print(image);
    // setState(() {
    // });

    return image;
  } catch (e) {
    print("Image picker error $e");
  }
}