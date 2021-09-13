import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:music_sliding_sheet/sliding_sheet.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/main/body/home_page.dart';
import 'package:stario/src/main/body/sub_screens/search_page.dart';
import 'package:stario/src/main/sheet_components/song_details_tab.dart';
import 'sheet_components/current_song_tab.dart';
import 'sheet_components/recently_played_list_page.dart';
import 'sheet_components/bottom_action_bar.dart';

enum bodyPages {
  mainBody,
  search,
}

class SongBottomSheet extends StatefulWidget {
  @override
  _SongBottomSheetState createState() => _SongBottomSheetState();
}

class _SongBottomSheetState extends State<SongBottomSheet> with SingleTickerProviderStateMixin {
  //Controller for the bottom sheet
  SheetController songSheetController = SheetController();

  //current shown page
  bodyPages body = bodyPages.mainBody;

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
        shadowColor: Colors.black,
        cornerRadius: 30,
        color: Theme.of(context).scaffoldBackgroundColor,
        //elevation: 100,
        scrollSpec: ScrollSpec(
          showScrollbar: true,
          physics: BouncingScrollPhysics(),
        ),
        addTopViewPaddingOnFullscreen: true,
        duration: Duration(milliseconds: 500),
        snapSpec: const SnapSpec(
          snappings: [SnapSpec.headerSnap, double.infinity],
          initialSnap: SnapSpec.headerSnap,
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
            child: body == bodyPages.search
                ? SearchPage(
                    onBackButtonTapped: (page) {
                      setState(() {
                        body = page;
                      });
                    },
                  )
                : MyHomePage(
                    onSearchBarTapped: (page) {
                      setState(() {
                        body = page;
                      });
                    },
                  ),
          ),
          bottomNavigationBar: Container(
            height: kCurrentSongTabHeight,
            width: double.infinity,
          ),
        ),
        headerBuilder: (BuildContext context, SheetState headerState) {
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
        // This is the list that shows what song has just been played
        // from either playlists
        builder: (BuildContext context, SheetState bodyState) {
          return RecentlyPlayedListPage();
        },
        // This is the details card that shows the current songs
        // full details including the duration
        footerBuilder: (BuildContext context, SheetState footerState) {
          return SongDetailsTab();
        },
      ),
      // This is the bar at the bottom that shows the loop, play, and shuffle buttons
      // This is placed at the bottomnavbar so that the sliding sheet can use header snap
      // and that we can place the detailstab inside the footer instead of the actionbar
      bottomNavigationBar: BottomActionBar(),
    );
  }
}
