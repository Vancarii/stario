import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stario/src/constants/constants.dart';

class PlayPauseButton extends StatefulWidget {
  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> with TickerProviderStateMixin {
  bool isPlaying = false;

  bool isLooped = false;

  AnimationController _playPauseIconAnimationController;

  @override
  void initState() {
    _playPauseIconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    _playPauseIconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(fadeInOutHeader());
    return Container(
      height: kPlayPauseButtonHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CupertinoButton(
              //padding: const EdgeInsets.all(15),
              onPressed: () {
                setState(() {
                  isLooped = !isLooped;
                });
              },
              child: Icon(
                Icons.all_inclusive,
                color: isLooped == false ? Colors.white : Theme.of(context).accentColor,
              ),
            ),
          ),
          Expanded(
            child: CupertinoButton(
              //padding: const EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  isPlaying = !isPlaying;
                  isPlaying
                      ? _playPauseIconAnimationController.forward()
                      : _playPauseIconAnimationController.reverse();
                });
              },
              child: AnimatedIcon(
                progress: _playPauseIconAnimationController,
                icon: AnimatedIcons.play_pause,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: CupertinoButton(
              //padding: const EdgeInsets.all(15),
              onPressed: () {},
              child: Icon(
                Icons.shuffle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
