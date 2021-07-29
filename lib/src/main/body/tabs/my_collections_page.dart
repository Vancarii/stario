import 'package:flutter/material.dart';
import 'package:stario/src/song_lists/liked_songs.dart';
import 'package:stario/src/widgets/song_tiles_listview.dart';

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
      //borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Container(
        margin: const EdgeInsets.all(7),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _collectionsPageRefreshKey.currentState?.show(atTop: true);
                    await Future.delayed(Duration(milliseconds: 1000));
                  },
                  child: SongTilesListView(
                    songList: likedSongs,
                    isFavouriteList: true,
                    physics: BouncingScrollPhysics(),
                  ),
                ),
              ),
              /*SizedBox(
                height: kPlayPauseButtonHeight + kCurrentSongTabHeight,
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
