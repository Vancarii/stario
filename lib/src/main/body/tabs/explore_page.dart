import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/genre_list/genre_list.dart';
import 'package:stario/src/models/my_genre_model.dart';
import 'package:stario/src/widgets/custom_physics.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _explorePageRefreshKey = GlobalKey<RefreshIndicatorState>();

  PageController _explorePageViewController;

  @override
  void initState() {
    _explorePageViewController = PageController();
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
          setState(() {
            showGenres = false;
          });
        }*/

        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          _explorePageRefreshKey.currentState?.show(atTop: true);
          await Future.delayed(Duration(milliseconds: 1000));
        },
        child: Container(
          child: ClipRRect(
            //borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: PageView.builder(
              controller: _explorePageViewController,
              physics: CustomScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(7),
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
    );
  }
}
