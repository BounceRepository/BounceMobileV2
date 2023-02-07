import 'dart:developer';

import 'package:bounce_patient_app/src/modules/playlist/models/audio_position_data.dart';
import 'package:bounce_patient_app/src/modules/playlist/models/song.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

const _error = 'Something went wrong';

class AudioPlayerController extends BaseController {
  final player = AudioPlayer();
  bool isPlaying = false;

  late ConcatenatingAudioSource _playlist;

  Future<void> init({required List<Song> songList}) async {
    try {
      if (player.playing) {
        await player.stop();
      }

      final audioSourceList = songList
          .map((element) => AudioSource.uri(
                Uri.parse('asset:///${element.url}'),
                tag: MediaItem(
                  id: Utils.getGuid(),
                  title: element.title,
                  artist: element.artist.fullName,
                  artUri: Uri.parse(element.image),
                ),
              ))
          .toList();
      _playlist = ConcatenatingAudioSource(
        // Start loading next item just before reaching it
        useLazyPreparation: true,
        // Customise the shuffle algorithm
        shuffleOrder: DefaultShuffleOrder(),
        // Specify the playlist items
        children: audioSourceList,
      );
      await player.setLoopMode(LoopMode.all);
      await player.setAudioSource(_playlist);
      await player.play();
      isPlaying = true;
      notifyListeners();
    } on Exception catch (e) {
      log(e.toString());
      throw Failure(_error);
    }
  }

  Future<void> play() async {
    try {
      await player.play();
      isPlaying = true;
      notifyListeners();
    } on Exception {
      throw Failure(_error);
    }
  }

  Future<void> pause() async {
    try {
      await player.pause();
      isPlaying = false;
      notifyListeners();
    } on Exception {
      throw Failure(_error);
    }
  }

  Future<void> stop() async {
    try {
      await player.stop();
      isPlaying = false;
      notifyListeners();
    } on Exception {
      throw Failure(_error);
    }
  }

  Future<void> seekToPrevious() async {
    try {
      await player.seekToPrevious();
      notifyListeners();
    } on Exception {
      throw Failure(_error);
    }
  }

  Future<void> seekToNext() async {
    try {
      await player.seekToNext();
      notifyListeners();
    } on Exception {
      throw Failure(_error);
    }
  }

  Future<void> seek(Duration duration) async {
    try {
      await player.seek(duration);
    } on Exception {
      throw Failure(_error);
    }
  }

  Stream<AudioPositionData> get positionDataStream => Rx.combineLatest3(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferPosition, duration) => AudioPositionData(
          position: position,
          bufferPosition: bufferPosition,
          duration: duration ?? Duration.zero,
        ),
      );

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
