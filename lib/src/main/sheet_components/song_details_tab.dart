import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stario/src/song_lists/explore_songs.dart';

class SongDetailsTab extends StatefulWidget {
  const SongDetailsTab({Key key}) : super(key: key);

  @override
  _SongDetailsTabState createState() => _SongDetailsTabState();
}

class _SongDetailsTabState extends State<SongDetailsTab> {
  double _currentSliderValue = 0.0;

  bool isFavourite = false;

  //TODO: Fix favourite button, duration slider, add func for action bar buttons

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: 250,
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: PageView.builder(
        itemCount: exploreSongs.length,
        itemBuilder: (context, index) {
          return Container(
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
                          child: Row(
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
                          ),
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
                                  '0:00',
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
          );
        },
      ),
    );
  }

  Widget songDurationSlider() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: 27,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(15.0),
                  right: Radius.circular(5.0),
                ),
                color: Theme.of(context).accentColor,
              ),
            ),
            SliderTheme(
              data: SliderThemeData(
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 13,
                  disabledThumbRadius: 13,
                  elevation: 0,
                  pressedElevation: 0,
                ),
                thumbColor: Theme.of(context).accentColor,
                inactiveTrackColor: Colors.transparent,
                overlayColor: Colors.transparent,
                trackHeight: 24.0,
                activeTrackColor: Theme.of(context).accentColor,
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Slider(
                value: _currentSliderValue,
                min: 0.0,
                max: 1.0,
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
            ),
          ],
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
              setState(() {});
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
