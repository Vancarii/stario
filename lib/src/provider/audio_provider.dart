import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:starioo/src/constants/constants.dart';
import 'package:starioo/src/song_lists/song_lists.dart';

class AudioProvider extends ChangeNotifier {
  AudioPlayer _audioPlayer = AudioPlayer();

  bool _isPlaying = false;
  String _currentPlaylist;
  int _currentIndex = 0;

  /// The current playlist that the song playing is from
  String get currentPlaylist => _currentPlaylist;

  /// The current index inside of the current playlist
  int get currentIndex => _currentIndex;

  /// If the song is playing or is paused
  bool get isPlaying => _isPlaying;

  /// Constructor of the Provider
  /// calls [initiateAudioPlayer] when the app starts
  AudioProvider() {
    print('constructor');
    initiateAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  /// this runs once when the app starts
  /// calls [loadPlaylist] with [kExplorePlaylist] passed through and then plays the first song
  initiateAudioPlayer() {
    print('initiate audio player');
    loadPlaylist(kExplorePlaylist).then((value) => playPauseAudio(true));
  }

  /// loads the playlist that the song is in which depends on which page it is on
  /// Also saves that playlist name into [_currentPlaylist] so that it can be retrieved
  Future<Duration> loadPlaylist(String playlist) {
    // TODO do not load a playlist if it is already loaded.
    _currentPlaylist = playlist;
    notifyListeners();
    return _audioPlayer
        .setAudioSource(
      ConcatenatingAudioSource(
        children: HardcodedPlaylists()
            .playlists[playlist]
            .map(
              (item) => AudioSource.uri(
                item.songPath,
                tag: item,
              ),
            )
            .toList(),
      ),
    )
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  /// seeks to the song specified by [index] in the loaded playlist
  seekTo(int index) {
    _audioPlayer.seek(Duration.zero, index: index);
    _currentIndex = index;
    print('index: $_currentIndex');
    notifyListeners();

/*    // animates the current playing song pageview in song_details_tab.dart
    detailsTabPageController.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.easeInOutQuart);
    currentSongTabController.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.easeInOutQuart);*/
  }

  /// starts playing the song from the specified position [value]
  void seekToPosition(Duration value) {
    _audioPlayer.seek(value);
  }

  /// checks if the current position is null
  /// returns 0 if null, and [_audioPlayer.positionStream] if != null
  /// Use a StreamBuilder to access the values of the positionStream
  Stream<Duration> get getCurrentPosition {
    Stream<Duration> position = Stream.value(Duration(milliseconds: 0));
    if (_audioPlayer.positionStream != null) {
      position = _audioPlayer.positionStream;
    }
    return position;
  }

  /// The entire duration of the whole song that is currently playing
  /// Checks if null, then returns either 0 or the [duration]
  Duration get songTotalDuration {
    Duration duration = Duration(milliseconds: 1);
    if (_audioPlayer.duration != null) {
      duration = _audioPlayer.duration;
    }
    return duration;
  }

  /// Plays or Pauses the audio depending on if [playing] is true or false
  /// Sets [_isPlaying] to [playing] so that it can be retrieved to check if playing or not
  void playPauseAudio(bool playing) {
    _isPlaying = playing;
    if (playing == false) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    notifyListeners();
  }
}
