import 'package:flutter/material.dart';
import 'package:stario/src/widgets/custom_physics.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _explorePageRefreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _explorePageRefreshKey.currentState?.show(atTop: true);
        await Future.delayed(Duration(milliseconds: 1000));
      },
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: PageView.builder(
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
          )),
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
