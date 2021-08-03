/*
 * File: hardcoded_collection_songs.dart
 * Project: Flutter music player
 * Created Date: Sunday March 28th 2021
 * Author: Michele Volpato
 * -----
 * Copyright (c) 2021 Michele Volpato
 */

import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/playlists/artist_model.dart';
import 'package:stario/src/playlists/song_model.dart';
import 'package:stario/src/services/playlists/playlists_service.dart';

class HardcodedPlaylistsService implements PlaylistsService {
  //add Uri.parse('link') when using Uri link
  final _exploreSongs = [
    SongModel(
      artist: ArtistModel("Xiuneng", null),
      songName: 'My Time',
      artworkLocation:
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/products/My-Time_1024x1024@2x.jpg?v=1625888091',
      songLocation: Uri.parse(
        "https://cdn.shopify.com/s/files/1/0580/5093/7012/files/My-Time.mp3?v=1626737167",
      ),
    ),
    SongModel(
      artist: ArtistModel("Xiuneng", null),
      songName: "Terrible Calm",
      artworkLocation:
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/products/Terrible-Calm_1024x1024@2x.jpg?v=1625888176',
      songLocation: Uri.parse(
        "https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Terrible-Calm.mp3?v=1626737167",
      ),
    ),
    SongModel(
      artist: ArtistModel("Xiuneng", null),
      songName: "Under the Moonlight",
      artworkLocation:
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/products/Under-the-Moonlight_540x.jpg?v=1625888220',
      songLocation: Uri.parse(
        "https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Under-the-Moonlight.mp3?v=1626737167",
      ),
    ),
  ];

  final _collectionSongs = [
    SongModel(
      artist: ArtistModel("Xiuneng", null),
      songName: 'My Time',
      artworkLocation:
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/products/My-Time_1024x1024@2x.jpg?v=1625888091',
      songLocation: Uri.parse(
        "https://cdn.shopify.com/s/files/1/0580/5093/7012/files/My-Time.mp3?v=1626737167",
      ),
    ),
    SongModel(
      artist: ArtistModel("Xiuneng", null),
      songName: "Terrible Calm",
      artworkLocation:
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/products/Terrible-Calm_1024x1024@2x.jpg?v=1625888176',
      songLocation: Uri.parse(
        "https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Terrible-Calm.mp3?v=1626737167",
      ),
    ),
    SongModel(
      artist: ArtistModel("Xiuneng", null),
      songName: "Under the Moonlight",
      artworkLocation:
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/products/Under-the-Moonlight_540x.jpg?v=1625888220',
      songLocation: Uri.parse(
        "https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Under-the-Moonlight.mp3?v=1626737167",
      ),
    ),
  ];

  final _mySongs = [
    SongModel(
      artist: ArtistModel("Xiuneng", null),
      songName: 'My Time',
      artworkLocation:
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/products/My-Time_1024x1024@2x.jpg?v=1625888091',
      songLocation: Uri.parse(
        "https://cdn.shopify.com/s/files/1/0580/5093/7012/files/My-Time.mp3?v=1626737167",
      ),
    ),
    SongModel(
      artist: ArtistModel("Xiuneng", null),
      songName: "Terrible Calm",
      artworkLocation:
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/products/Terrible-Calm_1024x1024@2x.jpg?v=1625888176',
      songLocation: Uri.parse(
        "https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Terrible-Calm.mp3?v=1626737167",
      ),
    ),
    SongModel(
      artist: ArtistModel("Xiuneng", null),
      songName: "Under the Moonlight",
      artworkLocation:
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/products/Under-the-Moonlight_540x.jpg?v=1625888220',
      songLocation: Uri.parse(
        "https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Under-the-Moonlight.mp3?v=1626737167",
      ),
    ),
  ];

  @override
  List<SongModel> get allItems {
    return []..addAll(_exploreSongs)..addAll(_collectionSongs)..addAll(_mySongs);
  }

  @override
  Map<String, List<SongModel>> get playlists {
    return {
      kExplorePlaylist: _exploreSongs,
      kCollectionsPlaylist: _collectionSongs,
      kMySongsPlaylist: _mySongs,
    };
  }

  @override
  // TODO: implement itemsByArtist
  Map<ArtistModel, List<SongModel>> get itemsByArtist => throw UnimplementedError();
}
