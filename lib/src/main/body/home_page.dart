import 'package:animations/animations.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stario/src/genre_list/genre_list.dart';
import 'package:stario/src/main/body/sub_screens/search_page.dart';
import 'package:stario/src/main/body/tabs/explore_page.dart';
import 'package:stario/src/main/body/tabs/my_collections_page.dart';
import 'package:stario/src/main/body/tabs/profile_page.dart';
import 'package:stario/src/main/song_bottom_sheet.dart';
import 'package:stario/src/models/my_genre_model.dart';
import 'package:stario/src/widgets/custom_physics.dart';
import 'package:extended_tabs/extended_tabs.dart';

class MyHomePage extends StatefulWidget {
  final Function(bodyPages) onSearchBarTapped;

  const MyHomePage({Key key, @required this.onSearchBarTapped}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

TabController tabController;

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<Tab> forumTabs = <Tab>[
    Tab(text: 'Explore'),
    Tab(text: 'My Collection'),
    Tab(text: 'Profile'),
  ];

  bool showGenres = false;
  double genreFilterButtonWidth = 65;

  String kExploreSearchText = 'Explore';
  String kMyCollectionSearchText = 'My Collection';
  String searchBarText;

  int currentSelectedGenreIndex;

  Genre selectedGenre;

  AnimationController _fadeAnimationController;
  AnimationController _slideAnimationController;

  Animation<double> _fadeAnimation;

  Animation<Offset> _slideAnimation;
  Animation<Color> _blackWhiteAnimation;
  Animation<Color> _whiteBlackAnimation;

  Animation<Color> tweenAnimation(Color beginColor, Color endColor) {
    return ColorTween(begin: beginColor, end: endColor).animate(tabController.animation);
  }

  Animation appbarAnimation(int time, int reversedTime) {
    return AnimationController(
        value: 1,
        duration: Duration(milliseconds: time),
        reverseDuration: Duration(milliseconds: reversedTime),
        vsync: this);
  }

  @override
  void initState() {
    searchBarText = kExploreSearchText;

    tabController = TabController(length: forumTabs.length, vsync: this);

    _slideAnimationController = appbarAnimation(400, 400);
    _fadeAnimationController = appbarAnimation(250, 100);

    _fadeAnimation = CurvedAnimation(parent: _fadeAnimationController, curve: Curves.linear);
    _slideAnimation = Tween<Offset>(begin: Offset(0.0, -0.5), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeInOutCirc));

    _blackWhiteAnimation = tweenAnimation(Color(0xfff222222), Colors.white);
    _whiteBlackAnimation = tweenAnimation(Colors.white, Color(0xfff222222));

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    _slideAnimationController.dispose();
    _fadeAnimationController.dispose();

    super.dispose();
  }

  handleSearchBarSwipeAnimation() {
    //HANDLES TABBARVIEW SWIPES APPBAR ANIMATION
    if (_fadeAnimationController.value == 1 &&
        tabController.offset >= 0.5 &&
        tabController.index == 1) {
      _fadeAnimationController.reverse();
      _slideAnimationController.reverse();
    }
    if (_fadeAnimationController.value == 0 &&
        tabController.offset < -0.5 &&
        tabController.index == 2) {
      _fadeAnimationController.forward();
      _slideAnimationController.forward();
    }
  }

  handleSearchBarTapAnimation() {
    //HANDLE TABBAR TAPS NOT SWIPES
    if (tabController.index == 0 && _fadeAnimationController.value != 1) {
      _fadeAnimationController.forward();
      _slideAnimationController.forward();
    }
    if (tabController.index == 1 && _fadeAnimationController.value != 1) {
      _fadeAnimationController.forward();
      _slideAnimationController.forward();
    }
    if (tabController.index == 2 && _fadeAnimationController.value != 0) {
      _fadeAnimationController.reverse();
      _slideAnimationController.reverse();
    }
  }

  handleSearchTextSwipeTransition() {
    if (searchBarText == kExploreSearchText &&
        tabController.index == 0 &&
        tabController.offset > 0.6) {
      setState(() {
        searchBarText = kMyCollectionSearchText;
      });
    }
    if (searchBarText == kMyCollectionSearchText &&
        tabController.index == 1 &&
        tabController.offset < -0.25) {
      setState(() {
        searchBarText = kExploreSearchText;
      });
    }
  }

  handleSearchTextTapTransition() {
    if (tabController.index == 0 && searchBarText != kExploreSearchText) {
      setState(() {
        searchBarText = kExploreSearchText;
      });
    } else if (tabController.index == 1 && searchBarText != kMyCollectionSearchText) {
      setState(() {
        searchBarText = kMyCollectionSearchText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        handleSearchBarSwipeAnimation();
        handleSearchTextSwipeTransition();
        if (notification is ScrollEndNotification) {
          handleSearchBarTapAnimation();
          handleSearchTextTapTransition();
        }
        return true;
      },
      child: InkWell(
        onTap: () {
          if (showGenres == true) {
            setState(() {
              showGenres = false;
            });
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          extendBodyBehindAppBar: true,
          //resizeToAvoidBottomInset: true,
          appBar: homeAppBar(),
          body: Stack(
            children: [
              ExtendedTabBarView(
                controller: tabController,
                physics: CustomScrollPhysics(),
                children: [
                  ExplorePage(),
                  MyCollectionsPage(),
                  ProfilePage(),
                ],
              ),
              floatingActionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget floatingActionButton() {
    return Positioned(
      bottom: 25.0,
      right: 25.0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            showGenres = true;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCirc,
          height: showGenres == false ? 65 : MediaQuery.of(context).size.height / 4,
          width: showGenres == false
              ? currentSelectedGenreIndex == null
                  ? 65
                  : MediaQuery.of(context).size.width - 50.0
              : MediaQuery.of(context).size.width - 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(showGenres == false ? 50.0 : 15.0)),

            /*gradient: LinearGradient(colors: [
                            Color(0xfff593FA9),
                            Color(0xfff5B5488),
                          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
*/
            color: Theme.of(context).accentColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2, 2),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
          ),
          child: showGenres == false
              ? currentSelectedGenreIndex != null
                  ? Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(selectedGenre.imagePath),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            selectedGenre.genre,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                showGenres = false;
                                currentSelectedGenreIndex = null;
                              });
                            },
                            child: Icon(
                              Icons.highlight_off,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Icon(
                      Icons.settings_input_component,
                      color: Theme.of(context).primaryColor,
                    )
              : MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 7.0,
                        crossAxisSpacing: 7.0,
                      ),
                      physics: BouncingScrollPhysics(),
                      // padding: const EdgeInsets.symmetric(vertical: 15.0),
                      itemCount: genres.length,
                      itemBuilder: (context, index) {
                        return buildGenreTiles(index);
                      },
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildGenreTiles(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (currentSelectedGenreIndex != index) {
            currentSelectedGenreIndex = index;
            showGenres = false;
            selectedGenre = genres[index];
          } else {
            currentSelectedGenreIndex = null;
          }
          //showGenres = false;
        });
      },
      child: Container(
        width: double.infinity,
        height: 100,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
              bottomLeft: Radius.circular(5.0)),
          border: currentSelectedGenreIndex == index
              ? Border.all(color: Theme.of(context).accentColor, width: 4)
              : Border.all(width: 0),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.multiply),
            fit: BoxFit.cover,
            image: AssetImage(genres[index].imagePath),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Wrap(
            children: [
              Text(
                genres[index].genre,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(110),
      child: SafeArea(
        child: SlideTransition(
          position: _slideAnimation,
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: Colors.transparent,
            toolbarHeight: 110,
            elevation: 0,
            title: AnimatedBuilder(
              builder: (BuildContext context, Widget child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: child,
                );
              },
              animation: _fadeAnimationController,
              child: searchBar(),
            ),
            bottom: tabBar(),
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        widget.onSearchBarTapped(bodyPages.search);
      },
      child: Container(
        width: double.infinity,
        height: 40.0,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 15.0),
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Search ',
              textAlign: TextAlign.start,
              style: TextStyle(
                inherit: false,
                fontSize: 16,
                color: Colors.white70,
                fontWeight: FontWeight.w400,
              ),
            ),
            //THIS EXPANDED, the container, and the unique key for the container that wraps the
            //text is crucial crucial crucial for the animation to be smooth and not jump around
            //when transitioning and have it aligned to the left of the container
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  key: UniqueKey(),
                  child: Text(
                    searchBarText,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      inherit: false,
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AnimatedBuilder(
        builder: (context, child) {
          return AnimatedBuilder(
            builder: (context, child) {
              return TabBar(
                controller: tabController,
                unselectedLabelColor: Colors.white.withOpacity(0.8),
                labelColor: _whiteBlackAnimation.value,
                tabs: forumTabs,
                isScrollable: true,
                labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                indicator: BubbleTabIndicator(
                  indicatorHeight: 35.0,
                  indicatorColor: _blackWhiteAnimation.value,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
              );
            },
            animation: _whiteBlackAnimation,
          );
        },
        animation: _blackWhiteAnimation,
      ),
    );
  }
}
