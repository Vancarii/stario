import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stario/src/provider/audio_provider.dart';
import 'package:stario/src/route_transitions/route_transitions.dart';
import 'package:stario/src/song_lists/explore_songs.dart';
import 'package:stario/src/widgets/custom_physics.dart';

class SongDetailsTab extends StatefulWidget {
  @override
  _SongDetailsTabState createState() => _SongDetailsTabState();
}

class _SongDetailsTabState extends State<SongDetailsTab> {
  double _currentSliderValue = 0.0;

  bool isFavourite = false;

  //AudioProvider _audioProvider;

  Duration currentSongPosition;

  @override
  void initState() {
   // _audioProvider = Provider.of<AudioProvider>(context, listen: false);
    //print(_audioProvider.audioPlayer.position);
    super.initState();
  }

  //TODO: Fix favourite button, duration slider, add func for action bar buttons

  @override
  Widget build(BuildContext context) {
/*    _audioProvider.audioPlayer.positionStream.listen((event) {
      currentSongPosition = event;
    });*/
    //print(Provider.of<AudioProvider>(context).audioPlayer.position);
    return Container(
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: 250,
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          color: Theme.of(context).accentColor.withOpacity(0.2),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  color: Colors.black38,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PageView.builder(
                          physics: CustomScrollPhysics(),
                          itemCount: exploreSongs.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Card(
                                  margin: const EdgeInsets.all(0),
                                  child: Image.asset(exploreSongs[index].imagePath),
                                  elevation: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        exploreSongs[index].songName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        exploreSongs[index].artistName,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              '0:00',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          songDurationSlider(),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '0:00', //'${_audioProvider.audioPlayer.duration.inMinutes}:${_audioProvider.audioPlayer.duration.inSeconds % 60}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actionBar(),
          ],
        ),
      ),
    );
  }

  Widget songDurationSlider() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: SliderTheme(
          data: SliderThemeData(
            thumbShape: SliderComponentShape.noThumb,
            thumbColor: Theme.of(context).accentColor,
            inactiveTrackColor: Theme.of(context).primaryColor.withOpacity(0.5),
            overlayColor: Colors.transparent,
            trackHeight: 24.0,
            activeTrackColor: Theme.of(context).accentColor,
            overlayShape: SliderComponentShape.noOverlay,
          ),
          child: Slider(
            value: _currentSliderValue,
            min: 0,
            max: 100,
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget actionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              setState(() {
                isFavourite = !isFavourite;
              });
            },
            child: Icon(
              isFavourite == false ? Icons.favorite_border : Icons.favorite,
              color: isFavourite == false ? Colors.grey : Colors.redAccent,
            ),
          ),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              setState(() {
                showShareSheet(context);
              });
            },
            child: Icon(
              Icons.share_outlined,
              color: Colors.grey,
            ),
          ),
          Spacer(),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              setState(() {});
            },
            child: Icon(
              Icons.more_vert,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
