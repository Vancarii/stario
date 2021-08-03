/*
 * File: song_model.dart
 * Project: Flutter music player
 * Created Date: Sunday March 28th 2021
 * Author: Michele Volpato
 * -----
 * Copyright (c) 2021 Michele Volpato
 */

import 'package:flutter/material.dart';

import 'artist_model.dart';

/// An audio item
class SongModel {
  /// The [ArtistModel] of this audio item.
  final ArtistModel artist;

  /// The title of this audio item.
  final String songName;

  /// The Uri to an image representing this audio item.
  final String artworkLocation;

  /// An Uri at which the audio can be found.
  // change this to:
  //final Uri songLocation when using a link to song location on web
  final Uri songLocation;

  SongModel({
    @required this.artist,
    @required this.songName,
    this.artworkLocation = "https://via.placeholder.com/150",
    @required this.songLocation,
  });
}
