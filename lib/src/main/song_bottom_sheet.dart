import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:music_sliding_sheet/sliding_sheet.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/main/body/home_page.dart';
import 'package:stario/src/main/body/sub_screens/search_page.dart';
import 'sheet_components/current_song_tab.dart';
import 'sheet_components/explore_song_list_page.dart';
import 'sheet_components/play_pause_button.dart';

class SongBottomSheet extends StatefulWidget {
  const SongBottomSheet({Key key}) : super(key: key);

  @override
  _SongBottomSheetState createState() => _SongBottomSheetState();
}

class _SongBottomSheetState extends State<SongBottomSheet> with SingleTickerProviderStateMixin {
  //Controller for the bottom sheet
  SheetController songSheetController = SheetController();

  bool searchBarTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*appBar: AppBar(
      //appBar that makes the body not extend past the android status bar
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
        backdropColor: Colors.black54,
        shadowColor: Colors.black54,
        color: Theme.of(context).scaffoldBackgroundColor,
        scrollSpec: ScrollSpec(
          showScrollbar: true,
          physics: BouncingScrollPhysics(),
        ),
        addTopViewPaddingOnFullscreen: true,
        duration: Duration(milliseconds: 300),
        snapSpec: const SnapSpec(
          snappings: [SnapSpec.headerFooterSnap, double.infinity],
          initialSnap: SnapSpec.headerFooterSnap,
        ),
        body: Scaffold(
          resizeToAvoidBottomInset: false,
          //Using this scaffold so that there is a gap below the body
          //so the body doesnt go behind the bottom sheet
          body: PageTransitionSwitcher(
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: searchBarTapped == false
                ? MyHomePage(
                    onSearchBarTap: (bool tapped) {
                      setState(() {
                        searchBarTapped = tapped;
                      });
                    },
                  )
                : SearchPage(
                    searchBarTapped: (bool tapped) {
                      setState(() {
                        searchBarTapped = tapped;
                      });
                    },
                  ),
          ),
          bottomNavigationBar: Container(
            height: kPlayPauseButtonHeight + kCurrentSongTabHeight,
            width: double.infinity,
          ),
        ),
        headerBuilder: (BuildContext context, SheetState state) {
          return SheetListenerBuilder(buildWhen: (oldState, newState) {
            //Sheet Listener is used so that it constantly checks to rebuild state when
            //new state is different than old state
            //in this case, once its different, it means it is changing
            //We then pass through the state progress to current song tab which uses the
            //progress values to animate the fade transition of the current Song Tab  to
            //the title of the sliding sheet
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
