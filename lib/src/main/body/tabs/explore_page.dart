import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starioo/src/constants/constants.dart';
import 'package:starioo/src/genre_list/genre_list.dart';
import 'package:starioo/src/models/genre_model.dart';
import 'package:starioo/src/widgets/custom_physics.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with AutomaticKeepAliveClientMixin {
  final _explorePageRefreshKey = GlobalKey<RefreshIndicatorState>();

  PageController _explorePageViewController;

  PageController _customSliverController;

  bool _isPinned = false;

  ScrollPhysics explorePagePhysics = NeverScrollableScrollPhysics();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _explorePageViewController = PageController();

    _customSliverController = PageController();

    /*_customSliverController.addListener(() {
      print('offset ${_customSliverController.offset}');
    });

    _explorePageViewController.addListener(() {
      if (!_isPinned &&
          _explorePageViewController.hasClients &&
          _explorePageViewController.offset > (MediaQuery.of(context).padding.top)) {
        setState(() {
          explorePagePhysics = CustomScrollPhysics();
          _isPinned = true;
          print('ispinned: $_isPinned');
        });
      } else if (_isPinned &&
          _explorePageViewController.hasClients &&
          _explorePageViewController.offset < (MediaQuery.of(context).padding.top)) {
        setState(() {
          explorePagePhysics = NeverScrollableScrollPhysics();
          _isPinned = false;
          print('ispinned: $_isPinned');
        });
      }
    });*/
    super.initState();
  }

  @override
  void dispose() {
    _explorePageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        /*if (_explorePageViewController.position.userScrollDirection != ScrollDirection.idle) {
          print('direct idle ${_explorePageViewController.position.userScrollDirection}');
          if (_explorePageViewController.position.userScrollDirection == ScrollDirection.forward) {
            setState(() {
              explorePagePhysics = NeverScrollableScrollPhysics();
            });
          } else if (_explorePageViewController.position.userScrollDirection ==
              ScrollDirection.reverse) {
            setState(() {
              explorePagePhysics = CustomScrollPhysics();
            });
          }
        }*/

        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          _explorePageRefreshKey.currentState?.show(atTop: true);
          await Future.delayed(Duration(milliseconds: 1000));
        },
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(7.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: NestedScrollView(
                scrollDirection: Axis.vertical,
                //controller: _customSliverController,
                //physics: BouncingScrollPhysics(),
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      stretch: true,
                      snap: true,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      expandedHeight: 80,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0, bottom: 10.0, right: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Find',
                                      style: GoogleFonts.lato(
                                        color: Colors.white54,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      'New Music',
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                CupertinoButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  onPressed: () {},
                                ),
                                CupertinoButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(
                                    Icons.settings_input_component,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height -
                          (kCurrentSongTabHeight +
                              kPlayPauseButtonHeight +
                              MediaQuery.of(context).padding.top),
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _explorePageViewController,
                        physics: explorePagePhysics,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 7.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/covers/eden.jpg'),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),*/
                  ];
                },
                body: Container(
                  height: MediaQuery.of(context).size.height -
                      (kCurrentSongTabHeight +
                          kPlayPauseButtonHeight +
                          MediaQuery.of(context).padding.top),
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: _explorePageViewController,
                    //physics: explorePagePhysics,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/covers/eden.jpg'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
