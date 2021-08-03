/*
 * File: playlists_service.dart
 * Project: Flutter music player
 * Created Date: Sunday March 28th 2021
 * Author: Michele Volpato
 * -----
 * Copyright (c) 2021 Michele Volpato
 */

import 'package:stario/src/playlists/artist_model.dart';
import 'package:stario/src/playlists/song_model.dart';

abstract class PlaylistsService {
  List<SongModel> get allItems;
  Map<String, List<SongModel>> get playlists;
  Map<ArtistModel, List<SongModel>> get itemsByArtist;
}
