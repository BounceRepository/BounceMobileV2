import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';
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
    return therapist;
    // return TherapistProfile(
    //   emailAddress: lorem(paragraphs: 1, words: 1),
    //   reviewCount: 0,
    //   title: lorem(paragraphs: 1, words: 1),
    //   yearsOfExperience: random.nextInt(100),
    //   aboutMe: lorem(paragraphs: 1, words: 10),
    //   commission: random.nextInt(100),
    //   consultationEndTime: '10:00 PM',
    //   consultationStartTime: '8:00 AM',
    //   consultationDays: [
    //     'Monday',
    //     'Tuesday',
    //     'Wednesday',
    //   ],
    //   country: '',
    //   firstName: '',
    //   lastName: '',
    //   gender: '',
    //   numberOfPatient: random.nextInt(100),
    //   phoneNumber: '',
    //   reviewRatio: random.nextInt(100).toDouble(),
    //   serviceChargePerHoure: random.nextInt(100),
    //   profilePicture: '',
    //   specialization: '',
    //   state: '',
    // );
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
    return list;
  }
}
