import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:flutter/material.dart';

class CustomChildScrollView extends StatelessWidget {
  const CustomChildScrollView({Key? key, required this.child, this.padding})
      : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: padding ?? AppPadding.defaultPadding,
      child: child,
    );
  }
}
