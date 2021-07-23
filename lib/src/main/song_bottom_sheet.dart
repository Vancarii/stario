import 'package:flutter/material.dart';
import 'package:music_sliding_sheet/sliding_sheet.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/main/body/home_page.dart';
import 'sheet_components/current_song_tab.dart';
import 'sheet_components/explore_song_list_page.dart';
import 'sheet_components/play_pause_button.dart';

class SongBottomSheet extends StatefulWidget {
  const SongBottomSheet({Key key}) : super(key: key);

  @override
  _SongBottomSheetState createState() => _SongBottomSheetState();
}

class _SongBottomSheetState extends State<SongBottomSheet> with SingleTickerProviderStateMixin {
  double sheetProgress;

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
        color: Theme.of(context).scaffoldBackgroundColor,
        scrollSpec: ScrollSpec(showScrollbar: true),
        addTopViewPaddingOnFullscreen: true,
        //margin: const EdgeInsets.symmetric(horizontal: 10.0),
        //cornerRadius: 15,
        // elevation: 15,
        cornerRadiusOnFullscreen: 0,
        duration: Duration(milliseconds: 500),
        snapSpec: const SnapSpec(
          positioning: SnapPositioning.pixelOffset,
          snappings: [kPlayPauseButtonHeight + kCurrentSongTabHeight, double.infinity],
          initialSnap: kPlayPauseButtonHeight + kCurrentSongTabHeight,
        ),
        body: Scaffold(
          body: MyHomePage(),
          bottomNavigationBar: Container(
            height: kPlayPauseButtonHeight + kCurrentSongTabHeight,
            width: double.infinity,
          ),
        ),
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
          //print(state.isAtBottom);
          return PlayPauseButton();
        },
      ),
    );
  }
}
