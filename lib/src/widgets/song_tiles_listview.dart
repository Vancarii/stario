import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stario/src/services/audio/audio_player_service.dart';
import 'package:stario/src/services/playlists/playlists_service.dart';

class SongTilesListView extends StatefulWidget {
  final String playlistName;
  final ScrollPhysics physics;
  final bool isFavouriteList;

  const SongTilesListView({
    Key key,
    @required this.playlistName,
    this.physics = const ScrollPhysics(),
    this.isFavouriteList = false,
  }) : super(key: key);

  @override
  _SongTilesListViewState createState() => _SongTilesListViewState();
}

class _SongTilesListViewState extends State<SongTilesListView> {
  List<int> favouritedSongs = [];

  int currentSelectedSongIndex;

  AudioPlayerService player;

  //AudioProvider _audioProvider;

  bool isFavourited(int index) {
    bool songIsFav = false;
    if (favouritedSongs.isNotEmpty) {
      for (var songIndex in favouritedSongs) {
        //print('songIndex $songIndex');
        if (songIndex == index) {
          songIsFav = true;
          break;
        } else {
          songIsFav = false;
        }
      }
    }
    return songIsFav;
  }

  @override
  void initState() {
    //This adds all the songs in the list to the local favorite list for the my collections page
    if (widget.isFavouriteList == true) {
      for (var i = 0; i <= widget.playlistName.length; i++) {
        favouritedSongs.add(i);
      }
    }
    player = Provider.of<AudioPlayerService>(context, listen: false);

    //_audioProvider = Provider.of<AudioProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistsService>(
      builder: (_, value, __) {
        return widget.isFavouriteList == true
            ? ReorderableListView.builder(
                onReorder: (oldIndex, newIndex) {
                  /*setState(() {
              print('old index : $oldIndex');
              print('new index : $newIndex');
              print('current : $currentSelectedSongIndex');

              if (oldIndex < newIndex) {
                newIndex -= 1;
                final SongModel movedSong = value.allItems.removeAt(oldIndex);
                value.allItems.insert(
                  newIndex,
                  movedSong,
                );
              }
            });*/
                },
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemCount: value.playlists[widget.playlistName].length,
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    key: Key('$index'),
                    onPressed: () {
                      setState(() {
                        player
                            .loadPlaylist(value.playlists[widget.playlistName])
                            .then((_) => player.seekToIndex(index))
                            .then((_) => player.play());
                        /* _audioProvider.audioPlayer.seek(
            Duration(),
          );
          //TODO: notify provider which song is tapped so it can play it and show in current song tab
          _audioProvider.audioPlayer.play();*/
                        currentSelectedSongIndex = index;
                      });
                    },
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      color: currentSelectedSongIndex == index
                          ? Theme.of(context).accentColor
                          : Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    value.playlists[widget.playlistName][index].artworkLocation,
                                  ),
                                ),
                              ),
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
                                    value.playlists[widget.playlistName][index].songName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    value.playlists[widget.playlistName][index].songName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white60,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  if (isFavourited(index) == false) {
                                    favouritedSongs.add(index);
                                  } else {
                                    for (var i = 0; i <= favouritedSongs.length; i++) {
                                      //print('i ${i}');
                                      if (favouritedSongs[i] == index) {
                                        //print(favouritedSongs[i]);
                                        favouritedSongs.removeAt(i);
                                        break;
                                      }
                                    }
                                  }
                                  //print('index $index');
                                  //print('isfavorited index: ${isFavourited(index).toString()}');
                                  //print('list: ${favouritedSongs.toString()}');
                                });
                              },
                              child: Container(
                                height: double.infinity,
                                width: 65,
                                child: Icon(
                                  isFavourited(index) == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      isFavourited(index) == true ? Colors.redAccent : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : ListView.builder(
                physics: widget.physics,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemCount: value.playlists[widget.playlistName].length,
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    key: Key('$index'),
                    onPressed: () {
                      setState(() {
                        player
                            .loadPlaylist(value.playlists[widget.playlistName])
                            .then((_) => player.seekToIndex(index))
                            .then((_) => player.play());
                        /* _audioProvider.audioPlayer.seek(
            Duration(),
          );
          //TODO: notify provider which song is tapped so it can play it and show in current song tab
          _audioProvider.audioPlayer.play();*/
                        currentSelectedSongIndex = index;
                      });
                    },
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      color: currentSelectedSongIndex == index
                          ? Theme.of(context).accentColor
                          : Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    value.playlists[widget.playlistName][index].artworkLocation,
                                  ),
                                ),
                              ),
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
                                    value.playlists[widget.playlistName][index].songName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    value.playlists[widget.playlistName][index].songName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white60,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  if (isFavourited(index) == false) {
                                    favouritedSongs.add(index);
                                  } else {
                                    for (var i = 0; i <= favouritedSongs.length; i++) {
                                      //print('i ${i}');
                                      if (favouritedSongs[i] == index) {
                                        //print(favouritedSongs[i]);
                                        favouritedSongs.removeAt(i);
                                        break;
                                      }
                                    }
                                  }
                                  //print('index $index');
                                  //print('isfavorited index: ${isFavourited(index).toString()}');
                                  //print('list: ${favouritedSongs.toString()}');
                                });
                              },
                              child: Container(
                                height: double.infinity,
                                width: 65,
                                child: Icon(
                                  isFavourited(index) == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      isFavourited(index) == true ? Colors.redAccent : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  /* Widget singleSongTile(int index) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      key: Key('$index'),
      onPressed: () {
        setState(() {
          */ /* _audioProvider.audioPlayer.seek(
            Duration(),
          );
          //TODO: notify provider which song is tapped so it can play it and show in current song tab
          _audioProvider.audioPlayer.play();*/ /*
          currentSelectedSongIndex = index;
        });
      },
      child: Container(
        height: 65,
        width: double.infinity,
        color:
            currentSelectedSongIndex == index ? Theme.of(context).accentColor : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(widget.songList[index].imagePath),
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
                      widget.songList[index].songName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.songList[index].artistName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white60,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  setState(() {
                    if (isFavourited(index) == false) {
                      favouritedSongs.add(index);
                    } else {
                      for (var i = 0; i <= favouritedSongs.length; i++) {
                        //print('i ${i}');
                        if (favouritedSongs[i] == index) {
                          //print(favouritedSongs[i]);
                          favouritedSongs.removeAt(i);
                          break;
                        }
                      }
                    }
                    //print('index $index');
                    //print('isfavorited index: ${isFavourited(index).toString()}');
                    //print('list: ${favouritedSongs.toString()}');
                  });
                },
                child: Container(
                  height: double.infinity,
                  width: 65,
                  child: Icon(
                    isFavourited(index) == true ? Icons.favorite : Icons.favorite_border,
                    color: isFavourited(index) == true ? Colors.redAccent : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}
