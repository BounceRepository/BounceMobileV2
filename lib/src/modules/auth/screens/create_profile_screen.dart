import 'dart:io';

import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/gender_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/datetime_helper_functions.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/notification_message.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/phone_number_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key, required this.email}) : super(key: key);

  final String email;

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
  File? image;

  @override
  void initState() {
    super.initState();
    _genderController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _dateOfBirthController = TextEditingController();
  }

  @override
  void dispose() {
    _genderController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final controller = context.read<AuthController>();
      final userId = controller.userId;
      final image = this.image;
      final gender = context.read<GenderController>().selectedGender;
      if (userId != null && image != null && gender != null) {
        try {
          await controller.createProfile(
            userId: userId,
            gender: gender,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            phoneNumber: _phoneNumberController.text,
            image: image,
            dateOfBirth: _dateOfBirthController.text,
          );
        } on Failure catch (e) {
          NotificationMessage.showError(context, message: e.message);
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
      image = await controller.pickImageFromGallery();
    } on Failure catch (e) {
      NotificationMessage.showError(context, message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: CustomChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const _AppBar(),
                  SizedBox(height: 10.h),
                  _ImageUploadSection(
                    onTap: _pickImage,
                  ),
                  SizedBox(height: 41.h),
                  Text(
                    widget.email,
                    style: AppText.bold500(context).copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const _GenderSection(),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Column(
                      children: [
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
                        SizedBox(height: 20.h),
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
                        SizedBox(height: 20.h),
                        CustomPhoneNumberTextfield(
                          controller: _phoneNumberController,
                          lableText: 'Phone Number',
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          readOnly: true,
                          controller: _dateOfBirthController,
                          lableText: 'Date of Birth',
                          suffixIcon: const TextFieldIcon(
                            icon: Icons.calendar_month,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter tap to select your date of birth';
                            }
                            return null;
                          },
                          onTap: _pickDate,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 37.h),
                  AuthButton(
                    label: 'Save',
                    onTap: _updateProfile,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageUploadSection extends StatelessWidget {
  const _ImageUploadSection({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: 130.h,
            width: 130.h,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.1),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(
              Icons.person,
              size: 66.sp,
              color: const Color(0xffC5B8B8),
            ),
          ),
          Positioned(
            bottom: -25.h,
            child: Container(
              height: 50.h,
              width: 50.h,
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.white),
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.primary,
                //boxShadow: [],
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          ),
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
        return Wrap(
          spacing: 50.w,
          children: List.generate(genders.length, (index) {
            final gender = genders[index];
            return button(context, gender);
          }),
        );
      },
    );
  }

  Widget button(BuildContext context, Gender gender) {
    return GestureDetector(
      onTap: () {
        context.read<GenderController>().select(gender.type);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 6.h,
          horizontal: 46.w,
        ),
        decoration: BoxDecoration(
          color: gender.isSelected ? AppColors.primary : const Color(0xffF2F2F2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          gender.type.name,
          style: AppText.bold500(context).copyWith(
            color: gender.isSelected ? Colors.white : AppColors.textBrown,
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(55.h);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 27.h,
        left: 23.w,
        right: 23.w,
        bottom: 11.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // backButton(
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          Text(
            'Bio -Data',
            style: AppText.bold600(context).copyWith(
              fontSize: 18.sp,
            ),
          ),
          // backButton(
          //   color: Colors.transparent,
          // ),
        ],
      ),
    );
  }

  Widget backButton({Color? color, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 51.h,
        width: 51.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: color != null
              ? null
              : [
                  BoxShadow(
                    color: const Color(0xffE76047).withOpacity(.47),
                    offset: const Offset(0, 10),
                    blurRadius: 26,
                  ),
                ],
        ),
        padding: EdgeInsets.all(14.sp),
        child: SvgPicture.asset(
          AppIcons.backBrokenArrow,
          height: 14.h,
          width: 14.h,
          color: color,
        ),
      ),
    );
  }
}
