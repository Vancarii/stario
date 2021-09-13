import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stario/src/main/body/sub_screens/artist_profile_page.dart';
import 'package:stario/src/provider/audio_provider.dart';
import 'package:stario/src/route_transitions/route_transitions.dart';
import 'package:stario/src/song_lists/song_lists.dart';
import 'package:stario/src/widgets/custom_physics.dart';

// The Widget that shows the current songs details including the current duration

class SongDetailsTab extends StatefulWidget {
  @override
  _SongDetailsTabState createState() => _SongDetailsTabState();
}

class _SongDetailsTabState extends State<SongDetailsTab> {
  bool isFavourite = false;

  // The current progress of the song
  Duration currentSongPosition;

  int previousIndex = 0;

  // controller for song_details_tab.dart
  PageController detailsTabPageController = PageController();

  @override
  Widget build(BuildContext context) {
/*    _audioProvider.audioPlayer.positionStream.listen((event) {
      currentSongPosition = event;
    });*/
    //print(Provider.of<AudioProvider>(context).audioPlayer.position);
    AudioProvider _provider = Provider.of<AudioProvider>(context, listen: false);
    AudioProvider _providerListener = Provider.of<AudioProvider>(context);

    print('prov index: ${_providerListener.currentIndex}');

    /*_providerListener
      ..addListener(() {
        */ /*if (_providerListener.currentIndex != previousIndex) {
          print('previous: $previousIndex');
          print('previous int: ${_providerListener.currentIndex}');
          detailsTabPageController.animateToPage(_providerListener.currentIndex,
              duration: Duration(milliseconds: 250), curve: Curves.easeInOutQuart);
          previousIndex = _providerListener.currentIndex;
        }*/ /*
      });*/
    return Container(
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: 250,
      ),
      //color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(2, 2),
              color: Colors.black54,
            )
          ],
          gradient: LinearGradient(
            colors: [
              Color(0xfff222222).withOpacity(0.7),
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          //color: Theme.of(context).primaryColor,
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
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Color(0xfff222222).withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PageView.builder(
                          physics: CustomScrollPhysics(),
                          onPageChanged: (int index) {
                            _provider.seekTo(index);
                          },
                          controller: detailsTabPageController,
                          itemCount: HardcodedPlaylists()
                              .playlists[_providerListener.currentPlaylist]
                              .length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Card(
                                  margin: const EdgeInsets.all(0),
                                  child: Image.asset(HardcodedPlaylists()
                                      .playlists[_providerListener.currentPlaylist]
                                          [_providerListener.currentIndex]
                                      .coverImagePath),
                                  elevation: 20.0,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          HardcodedPlaylists()
                                              .playlists[_providerListener.currentPlaylist]
                                                  [_providerListener.currentIndex]
                                              .songName,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        CupertinoButton(
                                          minSize: 0,
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                RouteTransitions().slideRightToLeftTransitionType(
                                                    ArtistProfilePage()));
                                          },
                                          child: Text(
                                            HardcodedPlaylists()
                                                .playlists[_providerListener.currentPlaylist]
                                                    [_providerListener.currentIndex]
                                                .artist
                                                .artistName,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white60,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    StreamBuilder<Duration>(
                        stream: _provider.getCurrentPosition,
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    snapshot.hasData
                                        ? '${snapshot.data.inMinutes}:${snapshot.data.inSeconds % 60 < 10 ? '0${snapshot.data.inSeconds % 60}' : snapshot.data.inSeconds % 60}'
                                        : '0:00',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                songDurationSlider(_provider, snapshot.data),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    '${_provider.songTotalDuration.inMinutes}:${_provider.songTotalDuration.inSeconds % 60 < 10 ? '0${_provider.songTotalDuration.inSeconds % 60}' : _provider.songTotalDuration.inSeconds % 60}',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
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

  Widget songDurationSlider(AudioProvider provider, Duration position) {
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
            value: position != null ? position.inMilliseconds.toDouble() : 0,
            min: 0,
            max: provider.songTotalDuration.inMilliseconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                //_currentSliderValue = value;
                var duration = Duration(milliseconds: value.toInt());
                provider.seekToPosition(duration);
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
