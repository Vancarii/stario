import 'package:flutter/material.dart';
import 'package:starioo/src/constants/constants.dart';
import 'package:starioo/src/widgets/song_tiles_listview.dart';

// The listview that shows all the songs that were recently played

/// TODO: Add func to either clear it with a button or clear it when it reaches a certain amount

class RecentlyPlayedListPage extends StatefulWidget {
  @override
  _RecentlyPlayedListPageState createState() => _RecentlyPlayedListPageState();
}

class _RecentlyPlayedListPageState extends State<RecentlyPlayedListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SongTilesListView(
        playlistName: kExplorePlaylist,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
