import 'dart:io';

import 'package:bounce_patient_app/src/modules/auth/models/create_profile_request.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';

enum CreateProfileLoadingState { pickImage, submit }

class CreateProfileController extends BaseController {
  final IAuthService _authService;
  final FileController _fileController;

  CreateProfileController({
    required IAuthService authService,
    required FileController fileController,
  })  : _fileController = fileController,
        _authService = authService;

  File? _image;
  File? get image => _image;

  Future<void> pickImage() async {
    try {
      setBusyForObject(CreateProfileLoadingState.pickImage, true);
      _image = await _fileController.pickImageFromGallery();
    } finally {
      setBusyForObject(CreateProfileLoadingState.pickImage, false);
    }
  }

  Gender selectedGender = Gender(type: GenderType.male, isSelected: true);
  final List<Gender> _genders = [
    Gender(type: GenderType.male, isSelected: true),
    Gender(type: GenderType.female),
  ];
  List<Gender> get genders => _genders;

  void select(GenderType type) {
    if (genders.isNotEmpty) {
      genders.firstWhere((element) => element.type == type).isSelected = true;
      _unSelectOthersUntil(type);
      notifyListeners();
    }
  }

  void _unSelectOthersUntil(GenderType type) {
    for (var item in genders) {
      if (item.type != type) {
        item.isSelected = false;
      }
    }
  }

  Future<void> execute(CreateProfileRequest request) async {
    try {
      setBusyForObject(CreateProfileLoadingState.submit, true);
      await _authService.createProfile(request);
    } finally {
      setBusyForObject(CreateProfileLoadingState.submit, true);
    }
  }
}
