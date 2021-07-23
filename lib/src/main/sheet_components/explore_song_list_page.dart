import 'package:flutter/material.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/song_lists/explore_songs.dart';
import 'package:stario/src/widgets/song_tiles_listview.dart';

class ExploreSongListPage extends StatefulWidget {
  @override
  _ExploreSongListPageState createState() => _ExploreSongListPageState();
}

class _ExploreSongListPageState extends State<ExploreSongListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - (kPlayPauseButtonHeight + kCurrentSongTabHeight),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: SingleChildScrollView(
              child: SongTilesListView(
                songList: exploreSongs,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 250,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
