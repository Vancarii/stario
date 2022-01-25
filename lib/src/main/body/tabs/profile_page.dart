import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/route_transitions/route_transitions.dart';
import 'package:stario/src/shared_prefs/shared_prefs.dart';
import 'package:stario/src/song_lists/song_lists.dart';
import 'package:stario/src/widgets/song_tiles_listview.dart';

import '../sub_screens/settings_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final ScrollController _sliverScrollController = ScrollController();

  TabController _tabViewController;

  bool isPinned = false;

  static const double profileExpandedHeight = 300;

  //final _firestore = FirebaseFirestore.instance;

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

      if (!isPinned &&
          _sliverScrollController.hasClients &&
          _sliverScrollController.offset > (profileExpandedHeight - kToolbarHeight)) {
        setState(() {
          isPinned = true;
          print('ispinned: $isPinned');
        });
      } else if (isPinned &&
          _sliverScrollController.hasClients &&
          _sliverScrollController.offset < (profileExpandedHeight - kToolbarHeight)) {
        setState(() {
          isPinned = false;
          print('ispinned: $isPinned');
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

  //String artistName;

/*  void getArtistName() {
    _firestore.collection('users').doc(SharedPrefs().username).get().then((value) {
      setState(() {
        artistName = value.data()['artist name'];
        print('artistName: $artistName');
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(left: 7.0, right: 7.0, bottom: 7.0, top: kToolbarHeight + 7.0),
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
                  profileCoverBar(),
                  profileInfoBar(),
                  profileActionBar(),
                  profileTabBar(),
                ];
              },
              body: ExtendedTabBarView(
                controller: _tabViewController,
                children: [
                  MySongsTab(),
                  MyAlbumsTab(),
                  AboutTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget profileCoverBar() {
    return SliverAppBar(
      stretch: true,
      //backgroundColor: Colors.transparent,
      pinned: true,
      elevation: 0,
      centerTitle: true,
      expandedHeight: profileExpandedHeight,
      titleSpacing: 5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CupertinoButton(
            onPressed: () {
              Navigator.push(
                  context, RouteTransitions().slideRightToLeftTransitionType(SettingsPage()));
            },
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Color(0xfff222222),
            padding: const EdgeInsets.all(0),
            child: Icon(
              Icons.settings,
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
                isPinned == false ? Color(0xfff222222) : Color(0xfff222222).withOpacity(0.7),
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
                    //takes the current logged in username from shared prefs class
                    SharedPrefs().artistName,
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

/*  Widget profileInfoBar() {
    return SliverAppBar(
      //backgroundColor: Color(0xfff222222),
      //toolbarHeight: 60,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 15.0),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '2530 ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      children: [
                        TextSpan(
                          text: 'Followers',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white70,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '26 ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      children: [
                        TextSpan(
                          text: 'Songs',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white70,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            profileIconButton(icon: Icons.reply, flipped: true),
          ],
        ),
      ),
    );
  }*/

  Widget profileInfoBar() {
    return SliverAppBar(
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

  Widget profileIconButton({IconData icon, bool flipped = false}) {
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
  }

  Widget profileActionBar() {
    return SliverAppBar(
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
                  'New Release',
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
                  'Edit Profile',
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

  Widget profileTabBar() {
    return SliverAppBar(
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

class MySongsTab extends StatefulWidget {
  const MySongsTab({Key key}) : super(key: key);

  @override
  _MySongsTabState createState() => _MySongsTabState();
}

class _MySongsTabState extends State<MySongsTab> {
  @override
  Widget build(BuildContext context) {
    return SongTilesListView(
      playlistName: kMySongsPlaylist,
    );
  }
}

class MyAlbumsTab extends StatefulWidget {
  const MyAlbumsTab({Key key}) : super(key: key);

  @override
  _MyAlbumsTabState createState() => _MyAlbumsTabState();
}

class _MyAlbumsTabState extends State<MyAlbumsTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AboutTab extends StatelessWidget {
  const AboutTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
