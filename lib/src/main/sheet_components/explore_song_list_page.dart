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
      height: MediaQuery.of(context).size.height,
      //color: Theme.of(context).scaffoldBackgroundColor,
      child: SongTilesListView(
        songList: exploreSongs,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
