import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_sliding_sheet/sliding_sheet.dart';
import 'package:provider/provider.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/provider/audio_provider.dart';
import 'package:stario/src/song_lists/song_lists.dart';
import 'package:stario/src/widgets/custom_physics.dart';

class CurrentSongTab extends StatefulWidget {
  final double sheetProgress;
  final SheetController sheetController;

  const CurrentSongTab({Key key, this.sheetProgress, this.sheetController}) : super(key: key);

  @override
  _CurrentSongTabState createState() => _CurrentSongTabState();
}

class _CurrentSongTabState extends State<CurrentSongTab> {
  bool sheetIsHalfway = false;

  bool isFavourite = false;

  // controller for current_song_tab.dart
  PageController currentSongTabController = PageController();

  // This controls the opacity and which widget to show for the sliding sheet's header
  // When the sheet is snapped to the bottom, it shows the currentsongtab, and fades out
  // as the sheet is sliding towards the middle of the screen, then the widget changes to the
  // 'Recently Played' title and fades in while the sheet scrolls to the top.
  double fadeInOutHeader({bool fadeOut = true}) {
    if (fadeOut == true) {
      if (1 - (widget.sheetProgress / 0.5) < 0) {
        setState(() {
          sheetIsHalfway = true;
        });
        return 0.0;
      } else {
        setState(() {
          sheetIsHalfway = false;
        });
        return 1 - (widget.sheetProgress / 0.5);
      }
    } else {
      if (widget.sheetProgress < 0.5) {
        setState(() {
          sheetIsHalfway = false;
        });
        return 0.0;
      } else {
        setState(() {
          sheetIsHalfway = true;
        });
        return (widget.sheetProgress * 2 - 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //AudioProvider _provider = Provider.of<AudioProvider>(context, listen: false);
    AudioProvider _providerListener = Provider.of<AudioProvider>(context);

    return sheetIsHalfway == true
        ? // The Title Widget
        Opacity(
            opacity: fadeInOutHeader(fadeOut: false),
            child: Container(
              width: double.infinity,
              height: kCurrentSongTabHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          widget.sheetController.snapToExtent(
                            SnapSpec.headerSnap,
                            duration: Duration(milliseconds: 250),
                          );
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Recently Played',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : // The currentSongTab widget
        Opacity(
            opacity: fadeInOutHeader(fadeOut: true),
            child: CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  widget.sheetController.snapToExtent(
                    SnapSpec.expanded,
                    duration: Duration(milliseconds: 250),
                  );
                });
              },
              child: Container(
                width: double.infinity,
                height: kCurrentSongTabHeight,
                //color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 6.0, bottom: 5.0),
                        width: 30,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              height: kCurrentSongTabHeight - 15.0,
                              width: 100,
                              color: Colors.transparent,
                              child: PageView.builder(
                                physics: CustomScrollPhysics(),
                                controller: currentSongTabController,
                                itemCount: HardcodedPlaylists()
                                    .playlists[_providerListener.currentPlaylist]
                                    .length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(HardcodedPlaylists()
                                                .playlists[_providerListener.currentPlaylist]
                                                    [_providerListener.currentIndex]
                                                .coverImagePath),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                      ),
                                      /*CircleAvatar(

                                        backgroundImage: AssetImage(HardcodedPlaylists()
                                            .playlists[_providerListener.currentPlaylist]
                                                [_providerListener.currentIndex]
                                            .coverImagePath),
                                      ),*/
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            HardcodedPlaylists()
                                                .playlists[_providerListener.currentPlaylist]
                                                    [_providerListener.currentIndex]
                                                .songName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            HardcodedPlaylists()
                                                .playlists[_providerListener.currentPlaylist]
                                                    [_providerListener.currentIndex]
                                                .artist
                                                .artistName,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
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
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
