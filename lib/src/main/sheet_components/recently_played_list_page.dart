import 'package:flutter/material.dart';
import 'package:starioo/src/constants/constants.dart';
import 'package:starioo/src/song_lists/song_lists.dart';
import 'package:starioo/src/widgets/song_tiles_listview.dart';

class RecentlyPlayedListPage extends StatefulWidget {
  @override
  _RecentlyPlayedListPageState createState() => _RecentlyPlayedListPageState();
}

class _RecentlyPlayedListPageState extends State<RecentlyPlayedListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      //color: Theme.of(context).scaffoldBackgroundColor,
      child: SongTilesListView(
        playlistName: kExplorePlaylist,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
