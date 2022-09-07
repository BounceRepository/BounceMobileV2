import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneNumberTextfield extends StatefulWidget {
  const CustomPhoneNumberTextfield({
    Key? key,
    required this.controller,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixText,
    this.filled = true,
    this.fillColor,
    this.lableText,
    this.hintText,
    this.hintTextStyle,
    this.border,
    this.errorText,
    this.contentPadding,
  }) : super(key: key);

  final TextEditingController controller;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? suffixText;
  final bool filled;
  final Color? fillColor;
  final String? lableText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final InputBorder? border;
  final String? errorText;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<CustomPhoneNumberTextfield> createState() => _CustomPhoneNumberTextfieldState();
}

class _CustomPhoneNumberTextfieldState extends State<CustomPhoneNumberTextfield> {
  String initialCountry = 'NG';
  final borderSide = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: const BorderSide(
      width: 0,
      color: Colors.transparent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: widget.controller,
      initialCountryCode: initialCountry,
      keyboardType: const TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
      //pickerDialogStyle: ,
      decoration: InputDecoration(
        isDense: true,
        counterText: "",
        filled: widget.filled,
        fillColor: widget.fillColor ?? AppColors.primary.withOpacity(.34),
        errorText: widget.errorText,
        errorStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.error,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 18.w,
            ),
        labelText: widget.lableText,
        hintText: widget.hintText,
        prefix: widget.prefix,
        prefixIcon: widget.prefixIcon,
        // prefixIconConstraints: const BoxConstraints(
        //   minWidth: 20,
        //   minHeight: 20,
        // ),
        suffixText: widget.suffixText,
        suffixIcon: widget.suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 25,
          minHeight: 25,
        ),
        suffixStyle: Theme.of(context).textTheme.titleSmall,
        hintStyle: widget.hintTextStyle ??
            AppText.bold300(context).copyWith(
              fontSize: 13.sp,
            ),
        labelStyle: AppText.bold300(context).copyWith(
          fontSize: 13.sp,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.error.withOpacity(.6),
            width: 1,
          ),
        ),
        enabledBorder: widget.border ?? borderSide,
        focusedBorder: widget.border ?? borderSide,
        disabledBorder: borderSide,
        border: widget.border ?? borderSide,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.error.withOpacity(.6),
            width: 1,
          ),
        ),
      ),
    );
  }
}
