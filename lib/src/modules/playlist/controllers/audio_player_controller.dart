import 'package:audioplayers/audioplayers.dart';
import 'package:bounce_patient_app/src/modules/playlist/models/song.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:flutter/cupertino.dart';

abstract class IAudioPlayerController extends ChangeNotifier {}

const _errorMessage = 'Failed to play song';

class AudioPlayerController extends ChangeNotifier {
  final _player = AudioPlayer();
  Duration _position = Duration.zero;
  Duration get position => _position;
  late Song _currentPlayingSong;
  Song get currentPlayingSong => _currentPlayingSong;
  List<Song> _songs = [];

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  void setIsPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  Future<void> loadSong(Song song) async {
    if (isPlaying) {
      _player.stop();
    }

    _currentPlayingSong = song;
    try {
      await _player.play(AssetSource(song.file.path));
      setIsPlaying(true);
    } on Exception {
      throw Failure(_errorMessage);
    } on Error {
      throw Failure(_errorMessage);
    }
  }

  Future<void> play() async {
    try {
      if (_isPlaying) {
        await _player.pause();
        setIsPlaying(false);
      } else {
        await _player.resume();
        setIsPlaying(true);
      }
    } on Exception {
      throw Failure(_errorMessage);
    } on Error {
      throw Failure(_errorMessage);
    }
  }

  void updateSong(Song song) {
    _currentPlayingSong = song;
    notifyListeners();
  }

  void updateSongList(List<Song> songs) {
    _songs = songs;
  }

  void onStateChanged() {
    _player.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    _player.onPositionChanged.listen((newPosition) {
      _position = newPosition;
      notifyListeners();
    });

    _player.onDurationChanged.listen((newPosition) {
      _position = newPosition;
      notifyListeners();
    });
  }

  Future<void> seek(int value) async {
    final position = Duration(seconds: value);

    try {
      await _player.seek(position);
      await _player.resume();
      setIsPlaying(true);
    } on Exception {
      throw Failure(_errorMessage);
    } on Error {
      throw Failure(_errorMessage);
    }
  }

  Future<void> playPrev() async {
    final index = _songs.indexWhere((element) => element.id == _currentPlayingSong.id);

    if (index == 0) {
      return;
    }

    final song = _songs[index - 1];
    try {
      await loadSong(song);
    } on Exception {
      throw Failure(_errorMessage);
    } on Error {
      throw Failure(_errorMessage);
    }
  }

  Future<void> playNext() async {
    final index = _songs.indexWhere((element) => element.id == _currentPlayingSong.id);

    if (index == _songs.length - 1) {
      return;
    }

    final song = _songs[index + 1];
    try {
      await loadSong(song);
    } on Exception {
      throw Failure(_errorMessage);
    } on Error {
      throw Failure(_errorMessage);
    }
  }

  Future<String> _loadAsset(Song song) async {
    try {
      final player = AudioCache(prefix: 'assets/audio/');
      final url = await player.load(song.file.path);
      return url.path;
    } on Exception {
      throw Failure(_errorMessage);
    } on Error {
      throw Failure(_errorMessage);
    }
  }
}
