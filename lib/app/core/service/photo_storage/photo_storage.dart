import 'dart:io';

abstract class PhotoStorage {
  Future<File?> takePhoto();
  Future<File?> pickPhoto();
}
