import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/song_list_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/fakes/fake_song_list_service_impl.dart';

void playListControllersInit({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(
        () => SongListController(songListService: FakeSongListService()));
  } else {
    diContainer.registerFactory(() => SongListController(songListService: diContainer()));
  }
}
