import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/genre_list/genre_list.dart';
import 'package:stario/src/models/genre_model.dart';
import 'package:stario/src/widgets/custom_physics.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _explorePageRefreshKey = GlobalKey<RefreshIndicatorState>();

  PageController _explorePageViewController;

  //bool isScrollingDown;\
  bool showGenres = false;
  double genreFilterButtonWidth = 65;

  int currentSelectedGenreIndex;

  Genre selectedGenre;

  @override
  void initState() {
    _explorePageViewController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (_explorePageViewController.position.userScrollDirection != ScrollDirection.idle) {
          setState(() {
            showGenres = false;
          });
        }

        /*if (notification is OverscrollNotification) {
          setState(() {
            showGenres = false;
          });
        }*/

        //print('offset ${_explorePageViewController.page}');
        //FORWARD IS UP
        //REVERSE IS DOWN
        //YOU KNOW WHAT IDLE MEANS
        /*setState(() {
          if (_explorePageViewController.position.userScrollDirection == ScrollDirection.forward) {
            print('forward');
            isScrollingDown = false;
          } else if (_explorePageViewController.position.userScrollDirection ==
              ScrollDirection.reverse) {
            print('reverse');
            isScrollingDown = true;
          } else if (_explorePageViewController.position.userScrollDirection ==
              ScrollDirection.idle) {
            print('idle');
            isScrollingDown = isScrollingDown;
          }
          if (isScrollingDown == false) {
            genreFilterButtonWidth = 125;
          } else {
            genreFilterButtonWidth = 65;
          }
        });*/

        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          _explorePageRefreshKey.currentState?.show(atTop: true);
          await Future.delayed(Duration(milliseconds: 1000));
        },
        child: InkWell(
          onTap: () {
            if (showGenres == true) {
              setState(() {
                showGenres = false;
              });
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            child: Stack(
              children: [
                PageView.builder(
                  controller: _explorePageViewController,
                  physics: CustomScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/covers/rehab.jpg'),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: kPlayPauseButtonHeight + kCurrentSongTabHeight + 25.0,
                  right: 25.0,
                  child: InkWell(
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
                        borderRadius:
                            BorderRadius.all(Radius.circular(showGenres == false ? 50.0 : 15.0)),
                        color: Colors.white,
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
                                  color: Colors.black,
                                )
                          : MediaQuery.removePadding(
                              removeTop: true,
                              context: context,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 7.0,
                                    crossAxisSpacing: 7.0,
                                  ),
                                  physics: BouncingScrollPhysics(),
                                  // padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  itemCount: 20,
                                  itemBuilder: (context, index) {
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
                                              ? Border.all(
                                                  color: Theme.of(context).accentColor, width: 4)
                                              : Border.all(width: 0),
                                          image: DecorationImage(
                                            colorFilter: ColorFilter.mode(
                                                Colors.black45, BlendMode.multiply),
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
                                  },
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    /*CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Container(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                  child: FilterChip(
                    label: Text('the lords chip'),
                    onSelected: (bool selected) {},
                    backgroundColor: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FilterChip(
                    label: Text('the lords chip'),
                    onSelected: (bool selected) {},
                    backgroundColor: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FilterChip(
                    label: Text('the lords chip'),
                    onSelected: (bool selected) {},
                    backgroundColor: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FilterChip(
                    label: Text('the lords chip'),
                    onSelected: (bool selected) {},
                    backgroundColor: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FilterChip(
                    label: Text('the lords chip'),
                    onSelected: (bool selected) {},
                    backgroundColor: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FilterChip(
                    label: Text('the lords chip'),
                    onSelected: (bool selected) {},
                    backgroundColor: Colors.white,
                  ),
                ),
                Padding(
                   padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                  child: FilterChip(
                    label: Text('More'),
                    onSelected: (bool selected) {},
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(color: Colors.white54, width: 1),
                ),
              );
            },
          ),
        ),
      ],
    );*/

    /*Stack(
      children: [
        GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          controller: _GridController,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.white54, width: 1),
              ),
            );
          },
        ),
        Container(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                child: FilterChip(
                  label: Text('the lords chip'),
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: FilterChip(
                  label: Text('the lords chip'),
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: FilterChip(
                  label: Text('the lords chip'),
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: FilterChip(
                  label: Text('the lords chip'),
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: FilterChip(
                  label: Text('the lords chip'),
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: FilterChip(
                  label: Text('the lords chip'),
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                child: FilterChip(
                  label: Text('More'),
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );*/
  }
}
