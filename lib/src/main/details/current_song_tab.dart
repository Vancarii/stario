import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:music_sliding_sheet/sliding_sheet.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/song_lists/explore_songs.dart';

class CurrentSongTab extends StatefulWidget {
  final double sheetProgress;
  final SheetController sheetController;

  const CurrentSongTab({Key key, this.sheetProgress, this.sheetController}) : super(key: key);

  @override
  _CurrentSongTabState createState() => _CurrentSongTabState();
}

class _CurrentSongTabState extends State<CurrentSongTab> {
  bool sheetIsHalfway = false;

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
    return sheetIsHalfway == true
        ? Opacity(
            opacity: fadeInOutHeader(fadeOut: false),
            child: Container(
              width: double.infinity,
              height: kCurrentSongTabHeight,
              color: Theme.of(context).primaryColorLight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.sheetController.snapToExtent(
                            SnapSpec.headerFooterSnap,
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
                    Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Opacity(
            opacity: fadeInOutHeader(fadeOut: true),
            child: InkWell(
              onTap: () {
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
                color: Theme.of(context).primaryColorLight,
                child: Column(
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              height: kCurrentSongTabHeight - 15.0,
                              width: 100,
                              color: Colors.transparent,
                              child: PageView.builder(
                                itemCount: exploreSongs.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(exploreSongs[index].imagePath),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            exploreSongs[index].songName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            exploreSongs[index].artistName,
                                            style: TextStyle(
                                              fontSize: 15,
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
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Icon(
                                Icons.fast_forward,
                                color: Colors.white,
                                size: 40,
                              ),
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
