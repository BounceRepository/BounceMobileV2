import 'package:bounce_patient_app/src/modules/onboarding/models/onboarding.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:flutter/cupertino.dart';

class OnboardingController extends ChangeNotifier {
  int pageNo = 0;
  PageController pageController = PageController();
  late Onboarding _currentOnboarding;
  Onboarding get currentOnboarding => _currentOnboarding;

  final onboardingList = [
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

  void init() {
    _currentOnboarding = onboardingList[0];
  }

  void precacheImages(BuildContext context) async {
    await Future.wait([
      precacheImage(AssetImage(onboardingList[0].image), context),
      precacheImage(AssetImage(onboardingList[1].image), context),
    ]);
  }

  void nextPage(int index) {
    pageNo = index;
    _currentOnboarding = onboardingList[index];
    notifyListeners();
  }

  void reset() {
    pageNo = 0;
    notifyListeners();
  }
}
