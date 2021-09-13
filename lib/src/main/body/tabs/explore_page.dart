import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:starioo/src/constants/constants.dart';
import 'package:starioo/src/provider/audio_provider.dart';
import 'package:starioo/src/widgets/custom_physics.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with AutomaticKeepAliveClientMixin {
  final _explorePageRefreshKey = GlobalKey<RefreshIndicatorState>();

  PageController _explorePageViewController;

  //PageController _customSliverController;

  //bool _isPinned = false;

  bool _showPlayPrompt = false;

  //ScrollPhysics explorePagePhysics = NeverScrollableScrollPhysics();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _explorePageViewController = PageController();

    //_customSliverController = PageController();

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
    AudioProvider _provider = Provider.of<AudioProvider>(context, listen: false);
    AudioProvider _providerListener = Provider.of<AudioProvider>(context);

    if (_providerListener.currentPlaylist == kExplorePlaylist) {
      setState(() {
        _showPlayPrompt = !_providerListener.isPlaying;
      });
    } else {
      setState(() {
        _showPlayPrompt = true;
      });
    }

    return NotificationListener(
      onNotification: (notification) {
        if (_explorePageViewController.position.userScrollDirection == ScrollDirection.forward ||
            _explorePageViewController.position.userScrollDirection == ScrollDirection.reverse) {
          setState(() {
            if (_showPlayPrompt == true) {
              if (_providerListener.currentPlaylist == kExplorePlaylist) {
                _provider.playPauseAudio(true);
              } else {
                _provider
                    .loadPlaylist(kExplorePlaylist)
                    .then((value) => _provider.seekTo(0))
                    .then((value) => _provider.playPauseAudio(true));
              }
            }
          });
        }

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
        child: Container(
          margin: const EdgeInsets.all(7.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: Container(
              height: MediaQuery.of(context).size.height -
                  (kCurrentSongTabHeight + kPlayPauseButtonHeight),
              width: double.infinity,
              child: PageView.builder(
                controller: _explorePageViewController,
                physics: CustomScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (_showPlayPrompt == true) {
                          if (_providerListener.currentPlaylist == kExplorePlaylist) {
                            _provider.playPauseAudio(true);
                          } else {
                            _provider
                                .loadPlaylist(kExplorePlaylist)
                                .then((value) => _provider.seekTo(0))
                                .then((value) => _provider.playPauseAudio(true));
                          }
                        } else {
                          _provider.playPauseAudio(false);
                        }

                        //TODO: Check if audio playing is from explore page
                        //_showPlayPrompt = !_showPlayPrompt;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          //margin: const EdgeInsets.symmetric(vertical: 7.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/covers/churchclothes.png'),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _showPlayPrompt,
                          child: Container(
                            color: Colors.black54,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 15.0, left: 25.0),
                                  height: 200,
                                  width: 1,
                                  color: Colors.white70,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Find',
                                      style: GoogleFonts.lato(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white54,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    Text(
                                      'New Music',
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 26.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                              ],
                            ),

                            /* Center(
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),*/
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
