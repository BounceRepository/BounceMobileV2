import 'dart:io';

import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/gender_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/health_level_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/select_health_level_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_up_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/datetime_helper_functions.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/select_location_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_checkbox.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({
    Key? key,
    required this.email,
    required this.userName,
    this.nextScreen,
  }) : super(key: key);

  final String email;
  final String userName;
  final Widget? nextScreen;

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _genderController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _dateOfBirthController;
  late final TextEditingController _locationController;
  late final TextEditingController _physicalHealthRateController;
  late final TextEditingController _mentalHealthRateController;
  late final TextEditingController _emotionalHealthRateController;
  late final TextEditingController _eatingHabitController;
  File? image;
  bool isLoadingImage = false;

  @override
  void initState() {
    super.initState();
    _genderController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _dateOfBirthController = TextEditingController();
    _locationController = TextEditingController();
    _physicalHealthRateController = TextEditingController();
    _mentalHealthRateController = TextEditingController();
    _emotionalHealthRateController = TextEditingController();
    _eatingHabitController = TextEditingController();
  }

  @override
  void dispose() {
    _genderController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    _locationController.dispose();
    _physicalHealthRateController.dispose();
    _mentalHealthRateController.dispose();
    _emotionalHealthRateController.dispose();
    _eatingHabitController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final controller = context.read<AuthController>();
      final user = AppSession.user;
      int? userId;

      if (user != null) {
        userId = user.id;
      } else {
        userId = controller.userId;
      }

      final image = this.image;
      final gender = context.read<GenderController>().selectedGender;
      if (userId != null) {
        if (image != null) {
          try {
            await controller.createProfile(
              userId: userId,
              gender: gender,
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              phoneNumber: _phoneNumberController.text,
              image: image,
              dateOfBirth: _dateOfBirthController.text,
              physicalHealtRate: _physicalHealthRateController.text,
              mentalHealtRate: _mentalHealthRateController.text,
              emotionalHealtRate: _emotionalHealthRateController.text,
              eatingHabit: _eatingHabitController.text,
            );
            AppSession.user = User(
              userName: widget.userName,
              gender: gender,
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              id: userId,
              email: widget.email,
              phone: '0${_phoneNumberController.text}',
              dateOfBirth: _dateOfBirthController.text,
            );
            AppNavigator.removeAllUntil(
                context, widget.nextScreen ?? const SignInScreen());
            Messenger.success(message: 'Profile updated successfully');
          } on Failure catch (e) {
            Messenger.error(message: e.message);
          }
        } else {
          Messenger.error(message: 'Upload your image');
        }
      }
    }
  }

  void _pickDate() async {
    final date = await DateTimeHelperFunctions.pickDate(context);
    if (date != null) {
      setState(() {
        _dateOfBirthController.text = date;
      });
    }
  }

  void _pickImage() async {
    final controller = context.read<ImageController>();
    try {
      setState(() => isLoadingImage = true);
      image = await controller.pickImageFromGallery();
      setState(() => isLoadingImage = false);
    } on Failure catch (e) {
      setState(() => isLoadingImage = false);
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        AppNavigator.removeAllUntil(context, const SignUpScreen());
        return Future.value(true);
      },
      child: Scaffold(
        appBar: const CustomAppBar(label: 'Edit Profile'),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: CustomChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: 40.h,
                horizontal: AppPadding.horizontal,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _ImageUploadSection(
                      image: image,
                      isLoading: isLoadingImage,
                      onTap: _pickImage,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.userName,
                      style: AppText.bold500(context).copyWith(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      'Please update your profile to get the best result from your therapist!',
                      style: AppText.bold300(context).copyWith(
                        fontSize: 14.sp,
                        color: AppColors.textBrown,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    CustomTextField(
                      controller: _firstNameController,
                      lableText: 'First Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      controller: _lastNameController,
                      lableText: 'Last Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.h),
                    const _GenderSection(),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      controller: _phoneNumberController,
                      lableText: 'Phone Number',
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      readOnly: true,
                      controller: _dateOfBirthController,
                      lableText: 'Date of Birth',
                      suffixIcon: const TextFieldIcon(
                        icon: Icons.calendar_month,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please  tap to select your date of birth';
                        }
                        return null;
                      },
                      onTap: _pickDate,
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      readOnly: true,
                      controller: _locationController,
                      lableText: 'Location',
                      suffixIcon: const TextFieldIcon(
                        icon: Icons.keyboard_arrow_down,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please tap to select your location';
                        }
                        return null;
                      },
                      onTap: () async {
                        final result = await showLocationBottomsheet(
                          context: context,
                          selectedOption: _locationController.text,
                          options: AppConstants.states,
                        );
                        if (result != null) {
                          _locationController.text = result;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      readOnly: true,
                      controller: _physicalHealthRateController,
                      lableText: 'Rate your physical health',
                      suffixIcon: const TextFieldIcon(
                        icon: Icons.keyboard_arrow_down,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please rate your physical health';
                        }
                        return null;
                      },
                      onTap: () async {
                        final result = await showHealthLevelBottomsheet<
                            PhysicalHealthLevelController>(context: context);

                        if (result != null) {
                          _physicalHealthRateController.text = result;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      readOnly: true,
                      controller: _mentalHealthRateController,
                      lableText: 'Rate your mental health',
                      suffixIcon: const TextFieldIcon(
                        icon: Icons.keyboard_arrow_down,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please rate your mental health';
                        }
                        return null;
                      },
                      onTap: () async {
                        final result =
                            await showHealthLevelBottomsheet<MentalHealthLevelController>(
                                context: context);

                        if (result != null) {
                          _mentalHealthRateController.text = result;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      readOnly: true,
                      controller: _emotionalHealthRateController,
                      lableText: 'Rate your emotional health',
                      suffixIcon: const TextFieldIcon(
                        icon: Icons.keyboard_arrow_down,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please rate your emotional health';
                        }
                        return null;
                      },
                      onTap: () async {
                        final result = await showHealthLevelBottomsheet<
                            EmotionalHealthLevelController>(context: context);

                        if (result != null) {
                          _emotionalHealthRateController.text = result;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      readOnly: true,
                      controller: _eatingHabitController,
                      lableText: 'Rate your eating habit',
                      suffixIcon: const TextFieldIcon(
                        icon: Icons.keyboard_arrow_down,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please rate your eating habit';
                        }
                        return null;
                      },
                      onTap: () async {
                        final result =
                            await showHealthLevelBottomsheet<EatingHabitLevelController>(
                                context: context);

                        if (result != null) {
                          _eatingHabitController.text = result;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(height: 37.h),
                    Consumer<AuthController>(
                      builder: (context, controller, _) {
                        return AuthButton(
                          label: 'Submit',
                          isLoading: controller.isLoading,
                          onTap: _updateProfile,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageUploadSection extends StatelessWidget {
  const _ImageUploadSection({
    Key? key,
    required this.image,
    required this.onTap,
    required this.isLoading,
  }) : super(key: key);

  final File? image;
  final Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isLoading
          ? Container(
              height: 88.h,
              width: 88.h,
              decoration: const BoxDecoration(
                color: AppColors.grey3,
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                height: 40.h,
                width: 40.h,
                child: const FittedBox(
                  fit: BoxFit.fill,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            )
          : Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.file(
                          image!,
                          height: 88.h,
                          width: 88.h,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      )
                    : const DefaultAppImage(),
              ],
            ),
    );
  }
}

class _GenderSection extends StatelessWidget {
  const _GenderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GenderController>(
      builder: (context, controller, _) {
        final genders = controller.genders;

        return Row(
          children: [
            button(context, genders[0]),
            SizedBox(width: 16.w),
            button(context, genders[1]),
          ],
        );
      },
    );
  }

  Widget button(BuildContext context, Gender gender) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<GenderController>().select(gender.type);
        },
        child: Container(
          width: 164.w,
          padding: EdgeInsets.symmetric(
            vertical: 14.h,
            horizontal: 14.w,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffFCE7D8).withOpacity(.24),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              CustomCheckBox(
                value: gender.isSelected,
                onChanged: (value) {
                  context.read<GenderController>().select(gender.type);
                },
              ),
              SizedBox(width: 10.w),
              Text(
                gender.type.name,
                style: AppText.bold500(context).copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
