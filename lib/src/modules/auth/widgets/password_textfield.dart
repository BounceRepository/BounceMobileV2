import 'package:bounce_patient_app/src/shared/utils/validator.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class _StrengthBar {
  bool isFilled;
  Color color;

  _StrengthBar({
    this.color = AppColors.primary,
    this.isFilled = false,
  });
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.title,
    this.showStrength = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? title;
  final bool showStrength;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final List<_StrengthBar> _strengthBars = [];
  bool _hidePassword = true;
  final bool _isMediumStrengthCheck = false;
  final bool _isStrongStrengthCheck = false;

  void _onToggleVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void _checkStrength(String value) {
    // if (value.isEmpty) {
    //   _isMediumStrengthCheck = false;
    //   _isStrongStrengthCheck = false;
    // } else {
    //   if (_isMediumStrengthCheck == false) {
    //     if (PasswordValidator.isMediumStrength(value)) {
    //       _isMediumStrengthCheck = true;
    //       _strengthBars.addAll([
    //         _StrengthBar(color: AppColors.primary),
    //         _StrengthBar(),
    //       ]);
    //       setState(() {});
    //     }
    //   } else if (_isStrongStrengthCheck == false) {
    //     if (PasswordValidator.isStrongStrength(value)) {
    //       _isStrongStrengthCheck = true;
    //       _strengthBars.addAll([
    //         _StrengthBar(),
    //         _StrengthBar(color: AppColors.primary),
    //       ]);
    //       setState(() {});
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final field = CustomTextField(
      title: widget.title,
      obscure: _hidePassword,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      lableText: widget.hintText ?? 'Password',
      suffixIcon: PasswordIcon(
        _hidePassword,
        onTap: _onToggleVisibility,
      ),
      onChanged: (value) => _checkStrength(value),
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (PasswordValidator.isNotCorrectLength(value)) {
              return 'Password must be a minimum of 8 characters';
            }
            return null;
          },
    );

    if (widget.showStrength) {
      return Column(
        children: [
          field,
          SizedBox(height: 8.h),
          _strengthBars.isNotEmpty
              ? Wrap(
                  spacing: 8.w,
                  children: List.generate(_strengthBars.length, (index) {
                    final bar = _strengthBars[index];
                    return strengthBar(bar);
                  }),
                )
              : const SizedBox.shrink(),
        ],
      );
    }

    return field;
  }

  Widget strengthBar(_StrengthBar bar) {
    return Wrap(
      spacing: 8.w,
      children: List.generate(2, (index) => indicator(bar)),
    );
  }

  Widget indicator(_StrengthBar bar) {
    return Container(
      width: 70.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: bar.color,
        borderRadius: BorderRadius.circular(5.r),
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
        _showPassword ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined,
        size: 20.sp,
        color: Colors.black54,
      ),
    );
  }
}
