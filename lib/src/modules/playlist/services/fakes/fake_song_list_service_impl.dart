import 'dart:io';
import 'dart:math';

import 'package:bounce_patient_app/src/modules/playlist/models/song.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/interfaces/song_list_service.dart';
import 'package:bounce_patient_app/src/shared/assets/audio.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeSongListServiceImpl implements ISongListService {
  final images = [SongImages.sample1, SongImages.sample2, SongImages.sample3];
  final songs = [AudioAssets.sample, AudioAssets.sample2, AudioAssets.sample3];

  @override
  Future<List<Song>> getAllMyPlaylist() async {
    await fakeNetworkDelay(seconds: 1);
    return List.generate(
        Random().nextInt(10),
        (index) => Song(
              id: Utils.getGuid(),
              title: lorem(paragraphs: 1, words: Random().nextInt(3) + 1),
              artist: Artist(
                id: Utils.getGuid(),
                firstName: lorem(paragraphs: 1, words: 1),
                lastName: lorem(paragraphs: 1, words: 1),
                nickName: lorem(paragraphs: 1, words: 1),
              ),
              tag: lorem(paragraphs: 1, words: 1),
              image: images[Random().nextInt(3)],
              file: File(songs[Random().nextInt(3)]),
              duration: const Duration(minutes: 4),
            ));
  }

  @override
  Future<List<Song>> getAllSong() async {
    await fakeNetworkDelay(seconds: 5);
    return List.generate(
        Random().nextInt(25),
        (index) => Song(
              id: Utils.getGuid(),
              title: lorem(paragraphs: 1, words: Random().nextInt(3) + 1),
              artist: Artist(
                id: Utils.getGuid(),
                firstName: lorem(paragraphs: 1, words: 1),
                lastName: lorem(paragraphs: 1, words: 1),
                nickName: lorem(paragraphs: 1, words: 1),
              ),
              tag: lorem(paragraphs: 1, words: 1),
              image: images[Random().nextInt(3)],
              file: File(songs[Random().nextInt(3)]),
              duration: const Duration(minutes: 4),
            ));
  }
}
