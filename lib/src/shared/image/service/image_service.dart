import 'dart:io';

import 'package:bounce_patient_app/src/shared/image/service/api_urls.dart';
import 'package:bounce_patient_app/src/shared/image/service/i_image_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

const _errorMessage = 'An error occuried';

class ImageService implements IImageService {
  final ImagePicker _imagePicker = ImagePicker();
  final IApi _api;

  ImageService({required IApi api}) : _api = api;

  @override
  Future<File?> pickImageFromCamera() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.camera);
      if (image == null) {
        return null;
      }
      return File(image.path);
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future<File?> pickImageFromGallery() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }
      return File(image.path);
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future<String> getImageUrl(File file) async {
    final fileName = file.path.split('/').last;
    Map<String, dynamic> body = {
      'formFile': await MultipartFile.fromFile(file.path, filename: fileName),
    };
    final formData = FormData.fromMap(body);

    try {
      final response = await _api.post(
        FileManagerApiURLS.getImageUrl,
        body: formData,
        isFormData: true,
      );
      return response['data']['filePath'];
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }
}
