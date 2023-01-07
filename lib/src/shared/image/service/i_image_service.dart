import 'dart:io';

abstract class IImageService {
  Future<File?> pickImageFromGallery();
  Future<File?> pickImageFromCamera();
  Future<String> getImageUrl(File file);
}
