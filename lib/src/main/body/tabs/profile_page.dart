import 'dart:ui';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stario/src/song_lists/my_songs.dart';
import 'package:stario/src/widgets/song_tiles_listview.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  final ScrollController _sliverScrollController = ScrollController();

  TabController _tabViewController;

  bool isPinned = false;

  static const double profileExpandedHeight = 300;

  @override
  void initState() {
    _tabViewController = TabController(length: 3, vsync: this);

/*    _sliverScrollController.addListener(() {
      if (_sliverScrollController.offset <= _sliverScrollController.position.minScrollExtent &&
          !_sliverScrollController.position.outOfRange) {
        print('reach top');
      }

      */

    /*if (!isPinned &&
          _sliverScrollController.hasClients &&
          _sliverScrollController.offset > (profileExpandedHeight - (kToolbarHeight * 2) - 40)) {
        setState(() {
          isPinned = true;
        });
      } else if (isPinned &&
          _sliverScrollController.hasClients &&
          _sliverScrollController.offset < (profileExpandedHeight - (kToolbarHeight * 2) - 40)) {
        setState(() {
          isPinned = false;
        });
      }*/ /*
    });*/
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
    return Container(
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight + 40),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          child: Scaffold(
            backgroundColor: Color(0xfff222222),
            body: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Padding(
                padding: const EdgeInsets.only(),
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
                      SongTilesListView(
                        songList: mySongs,
                      ),
                      MyAlbumsTab(),
                      AboutTab(),
                    ],
                  ),
                ),
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
      backgroundColor: Color(0xfff222222),
      pinned: true,
      elevation: 0,
      expandedHeight: profileExpandedHeight,
      titleSpacing: 5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /*CupertinoButton(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(0),
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {},
          ),*/
          CupertinoButton(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Color(0xfff222222),
            padding: const EdgeInsets.all(0),
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {},
          ),
        ],
      ),
      //collapsedHeight: kToolbarHeight * 2 + (kToolbarHeight / 2),
      //backgroundColor: Color(0xfff222222),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          decoration: BoxDecoration(
            color: Color(0xfff222222),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15.0),
            ),
            /*gradient: LinearGradient(
              colors: [
                isPinned == false ? Colors.transparent : Theme.of(context).primaryColor,
                Theme.of(context).primaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),*/
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 6.0, bottom: 4.0),
                        width: 25,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ),
                    Text(
                      'Xiuneng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        background: Container(
          child: Image.asset(
            'assets/genres/hiphop.jpg',
            fit: BoxFit.cover,
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
          alignment: Alignment.center,
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  '302,532 Monthly listeners',
                  style: TextStyle(fontSize: 12, color: Colors.white54),
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Songs',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white54,
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Albums',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white54,
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Followers',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white54,
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
      toolbarHeight: 80,
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
                    fontWeight: FontWeight.bold,
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
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.white12,
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
      toolbarHeight: 40,
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
                'SONGS',
              )),
          Container(
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              child: Text('ALBUMS')),
          Container(
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              child: Text('ABOUT')),
        ],
      ),
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
