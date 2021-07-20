import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stario/src/constants/constants.dart';

class PlayPauseButton extends StatefulWidget {
  const PlayPauseButton({Key key}) : super(key: key);

  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> with SingleTickerProviderStateMixin {
  bool isPlaying = false;

  bool isLooped = false;

  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kPlayPauseButtonHeight,
      width: double.infinity,
      //color: Theme.of(context).scaffoldBackgroundColor,
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
                  isPlaying ? _animationController.forward() : _animationController.reverse();
                });
              },
              child: AnimatedIcon(
                progress: _animationController,
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
