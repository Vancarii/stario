import 'dart:ui';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/route_transitions/route_transitions.dart';
import 'package:stario/src/widgets/song_tiles_listview.dart';
import '../sub_screens/settings_page.dart';

class ArtistProfilePage extends StatefulWidget {
  const ArtistProfilePage({Key key}) : super(key: key);

  @override
  _ArtistProfilePageState createState() => _ArtistProfilePageState();
}

class _ArtistProfilePageState extends State<ArtistProfilePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final ScrollController _sliverScrollController = ScrollController();

  TabController _tabViewController;

  bool _isPinned = false;

  static const double profileExpandedHeight = 300;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _tabViewController = TabController(length: 3, vsync: this);

    _sliverScrollController.addListener(() {
      if (_sliverScrollController.offset <= _sliverScrollController.position.minScrollExtent &&
          !_sliverScrollController.position.outOfRange) {
        print('reach top');
      }

/*      print('offset: ${_sliverScrollController.offset}');
      print('offset2: ${(profileExpandedHeight - (kToolbarHeight))}');*/

      if (!_isPinned &&
          _sliverScrollController.hasClients &&
          _sliverScrollController.offset > (profileExpandedHeight - kToolbarHeight)) {
        setState(() {
          _isPinned = true;
          print('ispinned: $_isPinned');
        });
      } else if (_isPinned &&
          _sliverScrollController.hasClients &&
          _sliverScrollController.offset < (profileExpandedHeight - kToolbarHeight)) {
        setState(() {
          _isPinned = false;
          print('ispinned: $_isPinned');
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabViewController.dispose();
    _sliverScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          child: Scaffold(
            backgroundColor: Color(0xfff222222),
            body: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: NestedScrollView(
                controller: _sliverScrollController,
                physics: BouncingScrollPhysics(),
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    _profileCoverBar(),
                    _profileInfoBar(),
                    _profileActionBar(),
                    _profileTabBar(),
                  ];
                },
                body: ExtendedTabBarView(
                  controller: _tabViewController,
                  children: [
                    SongTilesListView(
                      playlistName: kMySongsPlaylist,
                    ),
                    ArtistAlbumsTab(),
                    ArtistAboutTab(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileCoverBar() {
    return SliverAppBar(
      stretch: true,
      automaticallyImplyLeading: false,
      //backgroundColor: Colors.transparent,
      pinned: true,
      elevation: 0,
      centerTitle: true,
      expandedHeight: profileExpandedHeight,
      titleSpacing: 5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Color(0xfff222222),
            padding: const EdgeInsets.all(0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
          ),
          CupertinoButton(
            onPressed: () {
              Navigator.push(
                  context, RouteTransitions().slideRightToLeftTransitionType(SettingsPage()));
            },
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Color(0xfff222222),
            padding: const EdgeInsets.all(0),
            child: Icon(
              Icons.share,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          height: kToolbarHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                _isPinned == false ? Color(0xfff222222) : Color(0xfff222222).withOpacity(0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 6.0, bottom: 4.0),
                      width: 20,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),*/
                  Text(
                    'Xiuneng',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        background: Container(
          /*decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(100.0),
            ),
          ),*/
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50.0),
            ),
            child: Image.asset(
              'assets/genres/hiphop.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileInfoBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xfff222222),
      toolbarHeight: 75,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 15.0),
        title: Container(
          height: 75,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  '302,532 Monthly listeners',
                  style: GoogleFonts.lato(fontSize: 12, color: Colors.white54),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '15',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Songs',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '5',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Albums',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '240k',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Followers',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Widget _profileIconButton({IconData icon, bool flipped = false}) {
    return Container(
      height: 40.0,
      width: 40.0,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        //color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Icon(
        icon,
        textDirection: flipped == true ? TextDirection.rtl : TextDirection.ltr,
        color: Colors.white,
      ),
    );
  }*/

  Widget _profileActionBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 5,
      elevation: 0,
      toolbarHeight: 65,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Color(0xfff222222),
          /*borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),*/
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {},
              child: Container(
                height: 40,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Theme.of(context).accentColor,
                ),
                child: Text(
                  'Follow Artist',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {},
              child: Container(
                height: 40,
                alignment: Alignment.center,
                //margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.white12,
                ),
                child: Text(
                  'Shuffle Play',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileTabBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xfff222222),
      pinned: true,
      titleSpacing: 0,
      toolbarHeight: 55,
      elevation: 0,
      title: TabBar(
        controller: _tabViewController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white38,
        tabs: [
          Container(
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              child: Text(
                'Songs',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              )),
          Container(
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              child: Text(
                'Albums',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              )),
          Container(
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              child: Text(
                'About',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              )),
        ],
      ),
    );
  }
}

class ArtistAlbumsTab extends StatefulWidget {
  const ArtistAlbumsTab({Key key}) : super(key: key);

  @override
  _ArtistAlbumsTabState createState() => _ArtistAlbumsTabState();
}

class _ArtistAlbumsTabState extends State<ArtistAlbumsTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ArtistAboutTab extends StatelessWidget {
  const ArtistAboutTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
