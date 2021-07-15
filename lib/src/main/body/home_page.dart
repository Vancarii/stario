import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:stario/src/main/body/tabs/explore_page.dart';
import 'package:stario/src/main/body/tabs/my_collections_page.dart';
import 'package:stario/src/main/body/tabs/profile_page.dart';
import 'package:stario/src/widgets/custom_physics.dart';
import 'package:stario/src/widgets/custom_rounded_textfield.dart';

class MyHomePage extends StatefulWidget {
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

  bool canClear = false;

  FocusNode searchBarFocusNode = FocusNode();
  bool isFocused = false;

  TextEditingController _searchTextController = TextEditingController();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
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

        //HANDLE TABBAR TAPS NOT SWIPES
        if (notification is ScrollEndNotification) {
          if (tabController.index == 0) {
            _fadeAnimationController.forward();
            _slideAnimationController.forward();
          }
          if (tabController.index == 1) {
            _fadeAnimationController.forward();
            _slideAnimationController.forward();
          }
          if (tabController.index == 2) {
            _fadeAnimationController.reverse();
            _slideAnimationController.reverse();
          }
        }
        return true;
      },
      child: Builder(
        builder: (context) {
          tabController.addListener(() {});
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            //resizeToAvoidBottomInset: true,
            appBar: homeAppBar(),
            body: TabBarView(
              controller: tabController,
              //physics: CustomScrollPhysics(),
              children: [
                ExplorePage(),
                SafeArea(child: MyCollectionsPage()),
                ProfilePage(),
              ],
            ),
          );
        },
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: CustomRoundedTextField(
        node: searchBarFocusNode,
        keyboard: TextInputType.text,
        controller: _searchTextController,
        maxLines: 1,
        padding: const EdgeInsets.all(0.0),
        labelText: 'Search',
        //labelTextStyle: TextStyle(color: Colors.white.withOpacity(_fadeSearchLabelAnimation.value)),
        onTextChanged: (value) {
          setState(() {
            if (value == '') {
              canClear = false;
            } else {
              canClear = true;
            }
          });
        },
        endIcon: canClear == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _searchTextController.clear();
                    canClear = false;
                  });
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
              )
            : null,
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
