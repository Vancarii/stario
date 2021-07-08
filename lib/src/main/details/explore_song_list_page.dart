import 'package:flutter/material.dart';
import 'package:stario/src/song_lists/explore_songs.dart';

class ExploreSongListPage extends StatefulWidget {
  @override
  _ExploreSongListPageState createState() => _ExploreSongListPageState();
}

class _ExploreSongListPageState extends State<ExploreSongListPage> {
  int currentExploreSongIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).primaryColorLight.withOpacity(0.8),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemCount: exploreSongs.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                currentExploreSongIndex = index;
              });
            },
            child: Container(
              height: 65,
              width: double.infinity,
              color: currentExploreSongIndex == index
                  ? Theme.of(context).accentColor
                  : Colors.transparent,
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
                            image: AssetImage(exploreSongs[index].imagePath),
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
                            exploreSongs[index].songName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            exploreSongs[index].artistName,
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
            ),
          );
        },
      ),
    );
  }
}
