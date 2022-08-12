import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/phone_number_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomChildScrollView(
          child: Column(
            children: [
              const _AppBar(),
              const _ImageUploadSection(),
              SizedBox(height: 41.h),
              Text(
                'Smithwilliam34@yahoo.com',
                style: AppText.bold500(context).copyWith(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: TextEditingController(),
                      lableText: 'First Name',
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: TextEditingController(),
                      lableText: 'Last Name',
                    ),
                    SizedBox(height: 20.h),
                    CustomPhoneNumberTextfield(
                      controller: TextEditingController(),
                      lableText: 'Phone Number',
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      readOnly: true,
                      controller: TextEditingController(),
                      lableText: 'Date of Birth',
                      suffixIcon: const TextFieldIcon(
                        icon: Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 37.h),
              AuthButton(
                label: 'Update Profile',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageUploadSection extends StatelessWidget {
  const _ImageUploadSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          backButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text(
            'Bio -Data',
            style: AppText.bold600(context).copyWith(
              fontSize: 18.sp,
            ),
          ),
          backButton(
            color: Colors.transparent,
          ),
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
