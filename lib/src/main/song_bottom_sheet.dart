import 'package:flutter/material.dart';
import 'package:music_sliding_sheet/sliding_sheet.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/main/body/home_page.dart';
import 'details/current_song_tab.dart';
import 'details/explore_song_list_page.dart';
import 'details/play_pause_button.dart';

class SongBottomSheet extends StatefulWidget {
  const SongBottomSheet({Key key}) : super(key: key);

  @override
  _SongBottomSheetState createState() => _SongBottomSheetState();
}

class _SongBottomSheetState extends State<SongBottomSheet> with SingleTickerProviderStateMixin {
  double sheetPosition;

  SheetController songSheetController = SheetController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
        brightness: Brightness.dark,
      ),*/
      body: SlidingSheet(
        controller: songSheetController,
        closeOnBackdropTap: true,
        closeOnBackButtonPressed: true,
        isBackdropInteractable: true,
        shadowColor: Colors.black54,
        color: Colors.transparent,
        elevation: 15,
        scrollSpec: ScrollSpec(showScrollbar: true),
        //backdropColor: Colors.black,
        cornerRadius: 20,
        cornerRadiusOnFullscreen: 0,
        duration: Duration(milliseconds: 500),
        snapSpec: const SnapSpec(
          snappings: [SnapSpec.headerFooterSnap, double.infinity],
          initialSnap: SnapSpec.headerFooterSnap,
        ),
        body: MyHomePage(),
        headerBuilder: (BuildContext context, SheetState state) {
          return SheetListenerBuilder(buildWhen: (oldState, newState) {
            return oldState.progress != newState.progress;
          }, builder: (context, state) {
            return CurrentSongTab(
              sheetProgress: state.progress,
              sheetController: songSheetController,
            );
          });
        },
        builder: (BuildContext context, SheetState state) {
          return ExploreSongListPage();
        },
        footerBuilder: (context, state) {
          return PlayPauseButton();
        },
      ),
    );
  }
}
