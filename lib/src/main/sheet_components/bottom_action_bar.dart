import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stario/src/constants/constants.dart';

class BottomActionBar extends StatefulWidget {
  @override
  _BottomActionBarState createState() => _BottomActionBarState();
}

class _BottomActionBarState extends State<BottomActionBar> with TickerProviderStateMixin {
  bool isPlaying = false;

  AnimationController _playPauseIconAnimationController;

  //AUDIO
  AudioPlayer _audioPlayer;

  @override
  void initState() {
    _playPauseIconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    //AUDIO
    _audioPlayer = AudioPlayer();
    // Set a sequence of audio sources that will be played by the audio player.
    _audioPlayer.setAsset('assets/songs/eden-xiuneng.mp3')
        /*.setAudioSource(
      ConcatenatingAudioSource(
        children: [AudioSource.uri(Uri.file('/assets/songs/eden-xiuneng.mp3'))],
      ),
    )*/
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });

    super.initState();
  }

  @override
  void dispose() {
    _playPauseIconAnimationController.dispose();

    _audioPlayer.dispose();

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
                stream: _audioPlayer.loopModeStream,
                builder: (context, snapshot) {
                  return loopButton(context, snapshot.data ?? LoopMode.off);
                },
              ),
              playButton(),
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
            _audioPlayer.setLoopMode(
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

  Widget playButton() {
    return Expanded(
      child: CupertinoButton(
        //padding: const EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            if (_audioPlayer.playing == false) {
              print('falseeee');
              _audioPlayer.play();
              _playPauseIconAnimationController.forward();
            } else {
              print('trueeee');
              _audioPlayer.pause();
              _playPauseIconAnimationController.reverse();
            }
            /*isPlaying = !isPlaying;
                  isPlaying
                      ? _playPauseIconAnimationController.forward()
                      : _playPauseIconAnimationController.reverse();*/
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
