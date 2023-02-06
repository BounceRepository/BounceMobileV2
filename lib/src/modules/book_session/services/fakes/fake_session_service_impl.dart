import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeBookAppointmentServiceImpl implements IBookSessionService {
  @override
  Future<void> bookSession({
    required int patientId,
    required String reason,
    required int therapistId,
    required double price,
    required String startTime,
    required DateTime date,
    String? problemDesc,
  }) async {
    await fakeNetworkDelay();
  }

  @override
  Future<void> rescheduleSession({
    required int sessionId,
    required String startTime,
    required DateTime date,
  }) async {
    await fakeNetworkDelay();
    //throw InternalFailure();
  }

  @override
  Future<Therapist> getOneTherapist(int id) async {
    await fakeNetworkDelay();
    //throw InternalFailure();
    return Therapist(
      id: random.nextInt(100),
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
      serviceChargePerHour: random.nextInt(5000),
      reviewCount: random.nextInt(200),
      patientCount: random.nextInt(2000),
    );
  }

  @override
  Future<List<String>> getAvailableBookingTimeListForTherapist({
    required int therapistId,
    required DateTime date,
  }) async {
    await fakeNetworkDelay();
    //throw InternalFailure();
    final list = [
      '8:00 AM',
      '9:00 AM',
      '10:00 AM',
      '11:00 AM',
      '4:00 PM',
      '5:00 PM',
      '6:00 PM',
    ];
    list.shuffle();
    return [];
  }
}
