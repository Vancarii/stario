import 'package:flutter/cupertino.dart';

import 'artist_model.dart';

class Song {
  /// The name of the song
  String songName;

  /// the artist of the song
  Artist artist;

  /// the string path to the image of the cover art
  String coverImagePath;

  /// the string path to the song
  Uri songPath;

  Song({
    @required this.artist,
    @required this.songName,
    @required this.coverImagePath,
    @required this.songPath,
  });
}
