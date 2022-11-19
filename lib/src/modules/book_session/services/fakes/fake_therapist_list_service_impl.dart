import 'dart:math';

import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/therapist_list_service.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeTherapistListServiceImpl implements ITherapistListService {
  @override
  Future<List<Therapist>> getAllTherapist() async {
    await fakeNetworkDelay();
    return List.generate(5, (index) => therapist);
  }

  @override
  Future<List<Therapist>> getAllTherapistNearYou() async {
    await fakeNetworkDelay();
    return List.generate(8, (index) => therapist);
  }

  @override
  Future<List<Therapist>> getAllTopTherapist() async {
    await fakeNetworkDelay();
    return List.generate(3, (index) => therapist);
  }
}

final therapist = Therapist(
  id: Random().nextInt(100),
  title: 'Dr',
  firstName: 'Tochi',
  lastName: 'Appleyard',
  certifications: [
    'PHD',
  ],
  specializations: [
    'Psycology',
    'Psychiatry',
  ],
  desc: lorem(paragraphs: 1, words: 20),
  profilePicture: AppImages.image,
  rating: 4.5,
  experience: 5,
  phoneNumber: '0902000121',
  workingHours: WorkingHours(
    workDays: [
      WeekDays.monday,
      WeekDays.thursday,
      WeekDays.sunday,
    ],
    startTime: '8:00 AM',
    endTime: '5:00 PM',
  ),
  serviceChargePerHour: Random().nextInt(5000),
  reviews: Random().nextInt(200),
  patientCount: Random().nextInt(2000),
);
