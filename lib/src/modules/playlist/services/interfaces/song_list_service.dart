import 'package:bounce_patient_app/src/modules/playlist/models/song.dart';

abstract class ISongListService {
  Future<List<Song>> getAllSong();
  Future<List<Song>> getAllMyPlaylist();
}
