import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:location_box/app/core/service/photo_storage/photo_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoStorageImpl implements PhotoStorage {
  @override
  Future<File?> pickPhoto() async {
    if (await _requestGalleryPermission()) {
      XFile? getFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (getFile != null) {
        return File(getFile.path);
      }
    }
    return null;
  }

  @override
  Future<File?> takePhoto() async {
    if (await _requestCameraPermission()) {
      XFile? getFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (getFile != null) {
        return File(getFile.path);
      }
    }
    return null;
  }

  Future<bool> _requestGalleryPermission() async {
    var status = await Permission.storage.status;
    print(status);
    if (status.isGranted) {
      return true;
    } else {
      var result = await Permission.storage.request();
      return result.isGranted;
    }
  }

  Future<bool> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    print(status);
    if (status.isGranted) {
      return true;
    } else {
      var result = await Permission.camera.request();
      return result.isGranted;
    }
  }
}
