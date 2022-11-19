import 'package:bounce_patient_app/src/modules/playlist/models/song.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/interfaces/song_list_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class SongListController extends BaseController {
  final ISongListService _songListService;

  SongListController({required ISongListService songListService})
      : _songListService = songListService;

  List<Song> _songs = [];
  List<Song> get songs => _songs;
  List<Song> _myPlaylist = [];
  List<Song> get myPlaylist => _myPlaylist;

  Future<void> getAllPlaylist() async {
    reset();
    try {
      _myPlaylist = await _songListService.getAllMyPlaylist();
    } on Failure {
      rethrow;
    }
  }

  Future<void> getAllSong() async {
    reset();
    try {
      _songs = await _songListService.getAllSong();
    } on Failure {
      rethrow;
    }
  }
}
