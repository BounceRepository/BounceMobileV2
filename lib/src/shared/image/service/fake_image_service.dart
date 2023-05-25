import 'dart:io';

import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/image/service/i_image_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';

class FakeImageService implements IFileService {
  final _imagePicker = ImagePicker();

  @override
  Future<String> getImageUrl(File file) async {
    await fakeNetworkDelay();
    return AppImages.joinSession;
  }

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
}
