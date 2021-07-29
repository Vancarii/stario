import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/provider/audio_provider.dart';

class BottomActionBar extends StatefulWidget {
  @override
  _BottomActionBarState createState() => _BottomActionBarState();
}

class _BottomActionBarState extends State<BottomActionBar> with TickerProviderStateMixin {
  bool isPlaying = false;

  AudioProvider _audioProvider;

  AnimationController _playPauseIconAnimationController;

  //AUDIO
  //AudioPlayer _audioPlayer;

  @override
  void initState() {
    _playPauseIconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    //AUDIO
    _audioProvider = Provider.of<AudioProvider>(context, listen: false);

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
    //streambuilder not used yet
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        //final playerState = snapshot.data;
        return Container(
          height: kPlayPauseButtonHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<LoopMode>(
                stream: _audioProvider.audioPlayer.loopModeStream,
                builder: (context, snapshot) {
                  return loopButton(context, snapshot.data ?? LoopMode.off);
                },
              ),
              StreamBuilder(
                stream: _audioProvider.audioPlayer.playingStream,
                builder: (context, snapshot) {
                  return playButton(snapshot.data);
                },
              ),
              shuffleButton(),
            ],
          ),
        );
      },
    );
  }

  Widget loopButton(BuildContext context, LoopMode loopMode) {
    const cycleModes = [
      LoopMode.off,
      LoopMode.one,
    ];
    final index = cycleModes.indexOf(loopMode);
    return Expanded(
      child: CupertinoButton(
        onPressed: () {
          setState(() {
            _audioProvider.audioPlayer.setLoopMode(
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

  Widget playButton(bool isPlaying) {
    if (isPlaying == true) {
      _playPauseIconAnimationController.fling();
    } else {
      _playPauseIconAnimationController.reset();
    }
    return Expanded(
      child: CupertinoButton(
        onPressed: () {
          setState(() {
            if (_audioProvider.audioPlayer.playing == false) {
              _audioProvider.audioPlayer.play();
            } else {
              _audioProvider.audioPlayer.pause();
            }
          });
        },
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
