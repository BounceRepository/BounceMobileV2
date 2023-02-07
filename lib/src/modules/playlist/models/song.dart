import 'dart:io';

class Song {
  final String id;
  final String title;
  final Artist artist;
  final String tag;
  final String image;
  final String url;
  final Duration duration;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.tag,
    required this.url,
    required this.image,
    required this.duration,
  });

  // Future<Uint8List> get filebytes async {
  //   try {
  //     return await file.readAsBytes();
  //   } on Exception {
  //     throw InternalFailure();
  //   } on Error {
  //     throw InternalFailure();
  //   }
  // }
}

class Artist {
  final String id;
  final String firstName;
  final String lastName;
  final String nickName;

  Artist({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nickName,
  });

  String get fullName {
    return '$firstName $lastName';
  }
}
