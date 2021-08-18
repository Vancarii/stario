import 'package:starioo/src/constants/constants.dart';
import 'package:starioo/src/models/artist_model.dart';
import 'package:starioo/src/models/song_model.dart';

abstract class PlaylistsService {
  Map<String, List<Song>> get playlists;
}

class HardcodedPlaylists implements PlaylistsService {
  final List<Song> _exploreSongs = [
    Song(
      songName: 'Eden - Explore',
      artist: Artist(artistName: 'Xiuneng', profileImagePath: null),
      coverImagePath: 'assets/covers/eden.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/My-Time.mp3?v=1626737167'),
    ),
    Song(
      songName: 'Back in my Bag - Explore',
      artist: Artist(artistName: 'Aha Gazelle', profileImagePath: null),
      coverImagePath: 'assets/covers/backinmybag.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/My-Time.mp3?v=1626737167'),
    ),
    Song(
      songName: 'Carpool - Explore',
      artist: Artist(artistName: 'Aha Gazelle', profileImagePath: null),
      coverImagePath: 'assets/covers/trilliam.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/My-Time.mp3?v=1626737167'),
    ),
    Song(
      songName: 'Ramen and OJ - Explore',
      artist: Artist(artistName: 'Joyner Lucas, Lil Baby', profileImagePath: null),
      coverImagePath: 'assets/covers/ramenandoj.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/My-Time.mp3?v=1626737167'),
    ),
  ];

  final List<Song> _likedSongs = [
    Song(
      songName: 'Eden - Collection',
      artist: Artist(artistName: 'Xiuneng', profileImagePath: null),
      coverImagePath: 'assets/covers/eden.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Under-the-Moonlight.mp3?v=1626737167'),
    ),
    Song(
      songName: 'Back in my Bag - Collection',
      artist: Artist(artistName: 'Aha Gazelle', profileImagePath: null),
      coverImagePath: 'assets/covers/backinmybag.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Under-the-Moonlight.mp3?v=1626737167'),
    ),
    Song(
      songName: 'Carpool - Collection',
      artist: Artist(artistName: 'Aha Gazelle', profileImagePath: null),
      coverImagePath: 'assets/covers/trilliam.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Under-the-Moonlight.mp3?v=1626737167'),
    ),
    Song(
      songName: 'Ramen and OJ - Collection',
      artist: Artist(artistName: 'Joyner Lucas, Lil Baby', profileImagePath: null),
      coverImagePath: 'assets/covers/ramenandoj.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Under-the-Moonlight.mp3?v=1626737167'),
    ),
  ];

  final List<Song> _mySongs = [
    Song(
      songName: 'Eden - my Songs',
      artist: Artist(artistName: 'Xiuneng', profileImagePath: null),
      coverImagePath: 'assets/covers/eden.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Terrible-Calm.mp3?v=1626737167'),
    ),
    Song(
      songName: 'Back in my Bag - my Songs',
      artist: Artist(artistName: 'Aha Gazelle', profileImagePath: null),
      coverImagePath: 'assets/covers/backinmybag.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Terrible-Calm.mp3?v=1626737167'),
    ),
    Song(
      songName: 'Carpool - my Songs',
      artist: Artist(artistName: 'Aha Gazelle', profileImagePath: null),
      coverImagePath: 'assets/covers/trilliam.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Terrible-Calm.mp3?v=1626737167'),
    ),
    Song(
      songName: 'Ramen and OJ - my Songs',
      artist: Artist(artistName: 'Joyner Lucas, Lil Baby', profileImagePath: null),
      coverImagePath: 'assets/covers/ramenandoj.jpg',
      songPath: Uri.parse(
          'https://cdn.shopify.com/s/files/1/0580/5093/7012/files/Terrible-Calm.mp3?v=1626737167'),
    ),
  ];

  @override
  Map<String, List<Song>> get playlists {
    return {
      kExplorePlaylist: _exploreSongs,
      kCollectionsPlaylist: _likedSongs,
      kMySongsPlaylist: _mySongs
    };
  }
}
