import 'package:bounce_patient_app/src/modules/playlist/models/song.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/interfaces/song_list_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class SongListServiceImpl implements ISongListService {
  final IApi _api;

  SongListServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<Song>> getAllMyPlaylist() async {
    // TODO: implement getAllMyPlaylist
    throw UnimplementedError();
  }

  @override
  Future<List<Song>> getAllSong() async {
    // TODO: implement getAllSong
    throw UnimplementedError();
  }
}
