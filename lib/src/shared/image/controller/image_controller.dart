import 'dart:io';

import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/image/service/i_image_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class FileController extends BaseController {
  final IFileService _imageService;

  FileController({required IFileService imageService}) : _imageService = imageService;

  Future<File?> pickImageFromGallery() async {
    try {
      return await _imageService.pickImageFromGallery();
    } on Failure {
      rethrow;
    }
  }

  Future<File?> pickImageFromCamera() async {
    try {
      return await _imageService.pickImageFromCamera();
    } on Failure {
      rethrow;
    }
  }

  Future<String> getImageUrl(File file) async {
    reset();
    try {
      setIsLoading(true);
      final result = await _imageService.getImageUrl(file);
      setIsLoading(false);
      return result;
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
