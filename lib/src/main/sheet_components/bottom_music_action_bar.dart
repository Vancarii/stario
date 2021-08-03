import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/provider/audio_provider.dart';
import 'package:stario/src/services/audio/audio_player_service.dart';

class BottomMusicActionBar extends StatefulWidget {
  @override
  _BottomMusicActionBarState createState() => _BottomMusicActionBarState();
}

class _BottomMusicActionBarState extends State<BottomMusicActionBar> with TickerProviderStateMixin {
  bool isPlaying = false;

  //AudioProvider _audioProvider;

  AnimationController _playPauseIconAnimationController;

  //AUDIO
  //AudioPlayer _audioPlayer;

  @override
  void initState() {
    _playPauseIconAnimationController =
        AnimationController(value: 0, vsync: this, duration: Duration(milliseconds: 200));

    //AUDIO
    //_audioProvider = Provider.of<AudioProvider>(context, listen: false);

    /*_audioPlayer = AudioPlayer();
    // Set a sequence of audio sources that will be played by the audio player.
    _audioPlayer.setAsset('assets/songs/eden-xiuneng.mp3')
        */ /*.setAudioSource(
      ConcatenatingAudioSource(
        children: [AudioSource.uri(Uri.file('/assets/songs/eden-xiuneng.mp3'))],
      ),
    )*/ /*
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });*/

    super.initState();
  }

  @override
  void dispose() {
    _playPauseIconAnimationController.dispose();

    //_audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerService>(
      builder: (key, player, child) {
        return Container(
          height: kPlayPauseButtonHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<PlaylistLoopMode>(
                stream: player.loopMode, //_audioProvider.audioPlayer.loopModeStream,
                builder: (context, snapshot) {
                  return loopButton(context, snapshot.data ?? PlaylistLoopMode.off, player);
                },
              ),
              StreamBuilder<AudioProcessingState>(
                stream: player.audioProcessingState, //_audioProvider.audioPlayer.playingStream,

                builder: (context, snapshot) {
                  final playerState = snapshot.data ?? AudioProcessingState.unknown;
                  return playButton(playerState, player);
                },
              ),
              shuffleButton(),
            ],
          ),
        );
      },
    );
  }

  Widget loopButton(BuildContext context, PlaylistLoopMode loopMode, AudioPlayerService player) {
    const cycleModes = [
      PlaylistLoopMode.off,
      PlaylistLoopMode.one,
      PlaylistLoopMode.all,
    ];
    final index = cycleModes.indexOf(loopMode);
    return Expanded(
      child: CupertinoButton(
        onPressed: () {
          setState(() {
            player.setLoopMode(
              cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length],
            );
          });
        },
        child: Icon(
          Icons.all_inclusive,
          color: index == 0 ? Colors.white : Theme.of(context).accentColor,
        ),
      ),
    );
  }

  Widget playButton(AudioProcessingState processingState, AudioPlayerService player) {
    if (processingState == AudioProcessingState.idle) {
      print('idle');
      _playPauseIconAnimationController.reset();
    } else if (processingState == AudioProcessingState.ready) {
      //when audio plays then pauses, this is called
      print('ready');
      _playPauseIconAnimationController.reset();
    } else if (processingState != AudioProcessingState.completed) {
      //called right away
      print('!complete');
      _playPauseIconAnimationController.fling();
    }
    return Expanded(
      child: CupertinoButton(
        onPressed: processingState == AudioProcessingState.ready ? player.play : player.pause,
        child: AnimatedIcon(
          progress: _playPauseIconAnimationController,
          icon: AnimatedIcons.play_pause,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget shuffleButton() {
    return Expanded(
      child: CupertinoButton(
        //padding: const EdgeInsets.all(15),
        onPressed: () {},
        child: Icon(
          Icons.shuffle,
          color: Colors.white,
        ),
      ),
    );
  }
}
