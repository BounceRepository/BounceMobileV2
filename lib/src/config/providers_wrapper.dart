import 'package:bounce_patient_app/src/modules/appointment/controllers/book_appointment_controller.dart';
import 'package:bounce_patient_app/src/modules/appointment/controllers/therapist_list_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/gender_controller.dart';
import 'package:bounce_patient_app/src/modules/dashboard/controllers/navbar_controller.dart';
import 'package:bounce_patient_app/src/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvidersWrapper extends StatelessWidget {
  const ProvidersWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => diContainer<AuthController>()),
        ChangeNotifierProvider(create: (_) => diContainer<ImageController>()),
        ChangeNotifierProvider(create: (_) => diContainer<TherapistListController>()),
        ChangeNotifierProvider(create: (_) => diContainer<BookAppointmentController>()),
        ChangeNotifierProvider(create: (_) => OnboardingController()),
        ChangeNotifierProvider(create: (_) => GenderController()),
        ChangeNotifierProvider(create: (_) => NavbarController()),
      ],
      child: child,
    );
  }
}
