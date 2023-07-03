// lib/image_model.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// This enum will manage the overall state of the app
enum ImageSection {
  noStoragePermission, // Permission denied, but not forever
  noStoragePermissionPermanent, // Permission denied forever
  browseFiles, // The UI shows the button to pick files
  imageLoaded, // File picked and shown in the screen
}

class ImageModel extends ChangeNotifier {

  /// Request the files permission and updates the UI accordingly
  Future<bool> requestFilePermission() async {
    PermissionStatus result;
    // In Android we need to request the storage permission,
    // while in iOS is the photos permission
    if (Platform.isAndroid) {
      result = await Permission.manageExternalStorage.request();
    } else {
      result = await Permission.photos.request();
    }

    // if (result.isGranted) {
    //   imageSection = ImageSection.browseFiles;
    //   return true;
    // } else if (Platform.isIOS || result.isPermanentlyDenied) {
    //   imageSection = ImageSection.noStoragePermissionPermanent;
    // } else {
    //   imageSection = ImageSection.noStoragePermission;
    // }
    return false;
  }


}