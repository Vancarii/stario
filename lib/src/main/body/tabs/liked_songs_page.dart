import 'package:flutter/material.dart';
import 'package:stario/src/constants/constants.dart';
import 'package:stario/src/song_lists/liked_songs.dart';

class LikedSongsPage extends StatefulWidget {
  const LikedSongsPage({Key key}) : super(key: key);

  @override
  _LikedSongsPageState createState() => _LikedSongsPageState();
}

class _LikedSongsPageState extends State<LikedSongsPage> {
  bool isFavourite = true;

  final _likedSongsPageRefreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: Colors.black,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _likedSongsPageRefreshKey.currentState?.show(atTop: true);
                    await Future.delayed(Duration(milliseconds: 1000));
                  },
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: likedSongs.length,
                    itemBuilder: (context, index) {
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
                                      image: AssetImage(likedSongs[index].imagePath),
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
                                      likedSongs[index].songName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      likedSongs[index].artistName,
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
                                  setState(() {
                                    isFavourite = !isFavourite;
                                  });
                                },
                                child: Icon(
                                  isFavourite ? Icons.favorite : Icons.favorite_border,
                                  color: Color(0xfffdc143c),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: kPlayPauseButtonHeight + kCurrentSongTabHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
