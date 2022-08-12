import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final String? title;
  final String? lableText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextInputType? textInputType;
  final bool obscure;
  final bool? isPasswordTextField;
  final TextEditingController controller;
  final int? inputLimit;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final int maxLines;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? suffixText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final AutovalidateMode? autovalidateMode;
  final String? errorText;
  final bool filled;
  final Color? fillColor;
  final bool isMultipleLine;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    Key? key,
    this.title,
    this.lableText,
    this.hintText,
    this.hintTextStyle,
    this.textInputType,
    this.obscure = false,
    this.isPasswordTextField,
    required this.controller,
    this.inputLimit,
    this.inputFormatters,
    this.readOnly = false,
    this.maxLines = 1,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixText,
    this.validator,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.onTap,
    this.autovalidateMode,
    this.errorText,
    this.filled = true,
    this.fillColor,
    this.isMultipleLine = false,
    this.border,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderSide = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    );

    TextFormField field = TextFormField(
      //autofocus: true,
      style: AppText.bold500(context).copyWith(
        fontSize: 13.sp,
      ),
      keyboardType: textInputType,
      obscureText: obscure,
      maxLength: inputLimit,
      textInputAction: textInputAction,
      onTap: onTap,
      maxLines: (obscure == true) ? 1 : maxLines,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        isDense: true,
        counterText: "",
        filled: filled,
        fillColor: fillColor ?? AppColors.primary.withOpacity(.34),
        errorText: errorText,
        errorStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.error,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 18.w,
            ),
        labelText: lableText,
        hintText: hintText,
        prefix: prefix,
        prefixIcon: prefixIcon,
        // prefixIconConstraints: const BoxConstraints(
        //   minWidth: 20,
        //   minHeight: 20,
        // ),
        suffixText: suffixText,
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 25,
          minHeight: 25,
        ),
        suffixStyle: Theme.of(context).textTheme.titleSmall,
        hintStyle: hintTextStyle ??
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
        enabledBorder: border ?? borderSide,
        focusedBorder: border ?? borderSide,
        disabledBorder: borderSide,
        border: border ?? borderSide,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.error.withOpacity(.6),
            width: 1,
          ),
        ),
      ),
    );

    if (title != null) {
      final titlestyle = AppText.bold700(context).copyWith(
        fontSize: 17.sp,
      );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: titlestyle,
          ),
          SizedBox(height: 8.h),
          field,
        ],
      );
    } else {
      return field;
    }
  }
}

class TextFieldIcon extends StatelessWidget {
  const TextFieldIcon({
    Key? key,
    required this.icon,
    this.onTap,
    this.color,
    this.padding,
    this.size,
  }) : super(key: key);

  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 18.w),
        child: Icon(
          icon,
          size: size ?? 24.sp,
          color: color ?? AppColors.primary,
        ),
      ),
    );
  }
}

class TextFieldSvgIcon extends StatelessWidget {
  const TextFieldSvgIcon({
    Key? key,
    required this.icon,
    this.onTap,
    this.color,
    this.padding,
  }) : super(key: key);

  final String icon;
  final Color? color;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.only(left: 18.w, right: 8.w),
        child: SvgPicture.asset(
          icon,
          height: 24.h,
          width: 24.h,
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}

class PasswordIcon extends StatelessWidget {
  const PasswordIcon(
    this._showPassword, {
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final bool _showPassword;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        _showPassword ? Icons.visibility_off : Icons.remove_red_eye,
        size: 15.sp,
        color: Colors.black54,
      ),
    );
  }
}

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textBrown,
          ),
    );
  }
}
