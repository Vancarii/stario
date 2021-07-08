import 'package:flutter/material.dart';
import 'package:stario/src/constants/constants.dart';

class PlayPauseButton extends StatefulWidget {
  const PlayPauseButton({Key key}) : super(key: key);

  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> with SingleTickerProviderStateMixin {
  bool isPlaying = false;

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
    return InkWell(
      onTap: () {
        setState(() {
          isPlaying = !isPlaying;
          isPlaying ? _animationController.forward() : _animationController.reverse();
        });
      },
      child: Container(
        height: kPlayPauseButtonHeight,
        width: double.infinity,
        color: Theme.of(context).primaryColorLight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: AnimatedIcon(
                progress: _animationController,
                icon: AnimatedIcons.play_pause,
                size: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
