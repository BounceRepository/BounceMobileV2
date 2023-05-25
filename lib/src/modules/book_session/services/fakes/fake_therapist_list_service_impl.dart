import 'dart:math';

import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/therapist_list_service.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeTherapistListService implements ITherapistListService {
  @override
  Future<List<Therapist>> getAllTherapist() async {
    await fakeNetworkDelay();
    return List.generate(
        5,
        (index) => Therapist(
              id: Random().nextInt(100),
              title: 'Dr',
              firstName: lorem(words: 1, paragraphs: 1),
              lastName: lorem(words: 1, paragraphs: 1),
              certifications: [
                'PHD',
              ],
              specializations: lorem(words: 1, paragraphs: 1),
              email: 'applevinc@gmail.com',
              about: lorem(paragraphs: 1, words: 20),
              profilePicture: AppImages.joinSession,
              rating: 4.5,
              experience: 5,
              phoneNumber: '0902000121',
              workingHours: WorkingHours(
                workDays: [
                  WeekDays.monday,
                  WeekDays.thursday,
                  WeekDays.sunday,
                ],
                startTime: '5:00 PM',
                endTime: '8:00 AM',
              ),
              serviceChargePerHour: Random().nextInt(5000),
              reviewCount: Random().nextInt(200),
              patientCount: Random().nextInt(2000),
            ));
  }

  @override
  Future<List<Therapist>> getAllTherapistNearYou() async {
    await fakeNetworkDelay();
    return List.generate(
        8,
        (index) => Therapist(
              id: Random().nextInt(100),
              title: 'Dr',
              firstName: lorem(words: 1, paragraphs: 1),
              lastName: lorem(words: 1, paragraphs: 1),
              certifications: [
                'PHD',
              ],
              specializations: lorem(words: 1, paragraphs: 1),
              email: 'applevinc@gmail.com',
              about: lorem(paragraphs: 1, words: 20),
              profilePicture: AppImages.joinSession,
              rating: 4.5,
              experience: 5,
              phoneNumber: '0902000121',
              workingHours: WorkingHours(
                workDays: [
                  WeekDays.monday,
                  WeekDays.thursday,
                  WeekDays.sunday,
                ],
                startTime: '5:00 PM',
                endTime: '8:00 AM',
              ),
              serviceChargePerHour: Random().nextInt(5000),
              reviewCount: Random().nextInt(200),
              patientCount: Random().nextInt(2000),
            ));
  }

  @override
  Future<List<Therapist>> getAllTopTherapist() async {
    await fakeNetworkDelay();
    return List.generate(
        3,
        (index) => Therapist(
              id: Random().nextInt(100),
              title: 'Dr',
              firstName: lorem(words: 1, paragraphs: 1),
              lastName: lorem(words: 1, paragraphs: 1),
              certifications: [
                'PHD',
              ],
              specializations: lorem(words: 1, paragraphs: 1),
              email: 'applevinc@gmail.com',
              about: lorem(paragraphs: 1, words: 20),
              profilePicture: AppImages.joinSession,
              rating: 4.5,
              experience: 5,
              phoneNumber: '0902000121',
              workingHours: WorkingHours(
                workDays: [
                  WeekDays.monday,
                  WeekDays.thursday,
                  WeekDays.sunday,
                ],
                startTime: '5:00 PM',
                endTime: '8:00 AM',
              ),
              serviceChargePerHour: Random().nextInt(5000),
              reviewCount: Random().nextInt(200),
              patientCount: Random().nextInt(2000),
            ));
  }
}
