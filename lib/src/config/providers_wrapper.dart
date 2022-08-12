import 'package:bounce_patient_app/src/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvidersWrapper extends StatelessWidget {
  const ProvidersWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingController()),
      ],
      child: child,
    );
  }
}
