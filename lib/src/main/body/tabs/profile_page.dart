import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/models/song_model.dart';
import 'package:stario/src/song_lists/my_songs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  final ScrollController _sliverScrollController = ScrollController();

  bool isPinned = false;

  static const double profileExpandedHeight = 300;

  @override
  void initState() {
    _sliverScrollController.addListener(() {
      if (!isPinned &&
          _sliverScrollController.hasClients &&
          _sliverScrollController.offset > (profileExpandedHeight - (kToolbarHeight * 2) - 3)) {
        setState(() {
          isPinned = true;
        });
      } else if (isPinned &&
          _sliverScrollController.hasClients &&
          _sliverScrollController.offset < (profileExpandedHeight - (kToolbarHeight * 2) - 3)) {
        setState(() {
          isPinned = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      child: Container(
        //margin: const EdgeInsets.only(top: 120),
        decoration: BoxDecoration(
          color: Color(0xfff333333),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Scaffold(
          body: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: CustomScrollView(
              controller: _sliverScrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  stretch: true,
                  pinned: true,
                  elevation: 0,
                  expandedHeight: profileExpandedHeight,
                  collapsedHeight: kToolbarHeight * 2,
                  backgroundColor: Color(0xfff222222),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    titlePadding: const EdgeInsets.all(0),
                    title: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            isPinned == false ? Colors.transparent : Color(0xfff222222),
                            Theme.of(context).primaryColorLight,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, left: 15.0),
                        child: Row(
                          children: [
                            Text(
                              'Artist Name',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            Spacer(),
                            Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    background: Container(
                      foregroundDecoration: BoxDecoration(
                        color: Colors.black45,
                      ),
                      child: Image.asset(
                        'assets/covers/ramenandoj.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverAppBar(
                  backgroundColor: Color(0xfff222222),
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
                        Container(
                          height: 35.0,
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                            height: 35.0,
                            margin: const EdgeInsets.symmetric(),
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: Icon(
                              Icons.reply,
                              textDirection: TextDirection.rtl,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ),
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  titleSpacing: 5,
                  toolbarHeight: 80,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff222222),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                          child: Text(
                            'Shuffle Play',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Text(
                            'Release New',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 25.0, top: 10.0, bottom: 15.0, right: 15.0),
                    child: Row(
                      children: [
                        Text(
                          'Songs',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.sort,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        height: 65,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    image: DecorationImage(
                                      image: AssetImage(mySongs[index].imagePath),
                                    )),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mySongs[index].songName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      mySongs[index].artistName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white60,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.more_vert,
                                  size: 28,
                                  color: Color(0xfff333333),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: mySongs.length, // 1000 list items
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: kPlayPauseButtonHeight + kCurrentSongTabHeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
