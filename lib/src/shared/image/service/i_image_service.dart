import 'dart:io';

abstract class IFileService {
  Future<File?> pickImageFromGallery();
  Future<File?> pickImageFromCamera();
  Future<String> getImageUrl(File file);
}
