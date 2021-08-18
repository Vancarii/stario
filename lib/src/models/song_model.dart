import 'package:flutter/cupertino.dart';

import 'artist_model.dart';

class Song {
  String songName;
  Artist artist;
  String coverImagePath;
  Uri songPath;

  Song({
    @required this.artist,
    @required this.songName,
    @required this.coverImagePath,
    @required this.songPath,
  });
}
