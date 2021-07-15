import 'package:flutter/material.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/song_lists/liked_songs.dart';
import 'package:stario/src/widgets/list_of_songs.dart';

class MyCollectionsPage extends StatefulWidget {
  const MyCollectionsPage({Key key}) : super(key: key);

  @override
  _MyCollectionsPageState createState() => _MyCollectionsPageState();
}

class _MyCollectionsPageState extends State<MyCollectionsPage> {
  final _collectionsPageRefreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _collectionsPageRefreshKey.currentState?.show(atTop: true);
                  await Future.delayed(Duration(milliseconds: 1000));
                },
                child: ListOfSongs(
                  songList: likedSongs,
                  isFavouriteList: true,
                ),
              ),
            ),
            SizedBox(
              height: kPlayPauseButtonHeight + kCurrentSongTabHeight,
            ),
          ],
        ),
      ),
    );
  }
}
