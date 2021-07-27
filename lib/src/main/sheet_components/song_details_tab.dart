import 'dart:ui';
import 'package:flutter/material.dart';

class SongDetailsTab extends StatefulWidget {
  const SongDetailsTab({Key key}) : super(key: key);

  @override
  _SongDetailsTabState createState() => _SongDetailsTabState();
}

class _SongDetailsTabState extends State<SongDetailsTab> {
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: 200,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/covers/gravity.jpg'),
                      )),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Song Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Artist Name',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white60,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
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
                          inactiveTrackColor: Theme.of(context).accentColor.withOpacity(0.2),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
