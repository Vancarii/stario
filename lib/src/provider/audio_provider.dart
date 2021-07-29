import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  /* AudioPlayer _audioPlayer;

  AudioProvider() {
    _audioPlayer = AudioPlayer();
    // Set a sequence of audio sources that will be played by the audio player.
    _audioPlayer.setAsset('assets/songs/eden-xiuneng.mp3')
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


  void playPauseButtonTapped(bool isPlaying){
      if (isPlaying == true){
        _audioPlayer.pause();
      } else {
        _audioPlayer.play();
      }
      notifyListeners();
  }*/
}
