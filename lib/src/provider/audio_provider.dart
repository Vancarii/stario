import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  AudioPlayer audioPlayer;

  AudioProvider() {
    audioPlayer = AudioPlayer();

    // Set a sequence of audio sources that will be played by the audio player.
    audioPlayer.setAsset('assets/songs/eden-xiuneng.mp3').catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

/*  void playPauseButtonTapped(bool isPlaying) {
    if (isPlaying == true) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    notifyListeners();
  }*/
}
