import 'package:bounce_patient_app/src/modules/onboarding/models/onboarding.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';

class OnboardingController extends ChangeNotifier {
  int pageNo = 0;
  CarouselController carouselController = CarouselController();

  final onboardings = [
    Onboarding(
      title: 'Get Instant Consult From Your Preferred Therapist',
      description:
          'Now you can speak to your preferred doctor within 1 minute through chat/voice call/ video call',
      image: OnboardingImages.image1,
    ),
    Onboarding(
      title: 'Find Trustworthy Health Information',
      description: 'We will get you the right help, you need always.',
      image: OnboardingImages.image2,
    ),
  ];

  void precacheImages(BuildContext context) async {
    await Future.wait([
      precacheImage(AssetImage(onboardings[0].image), context),
      precacheImage(AssetImage(onboardings[1].image), context),
    ]);
  }

  void nextPage(int index) {
    pageNo = index;
    notifyListeners();
  }

  void reset() {
    pageNo = 0;
    notifyListeners();
  }
}
