import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:starioo/src/models/song_model.dart';
import 'package:starioo/src/provider/audio_provider.dart';
import 'package:starioo/src/song_lists/song_lists.dart';

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

  AudioProvider _audioProvider;

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

    _audioProvider = Provider.of<AudioProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFavouriteList == true
        ? ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) {
              /*setState(() {
                print('old index : $oldIndex');
                print('new index : $newIndex');
                print('current : $currentSelectedSongIndex');

                if (oldIndex < newIndex) {
                  newIndex -= 1;
                  */ /*currentSelectedSongIndex -= 1;
                  if (oldIndex - 1 == currentSelectedSongIndex) {
                    currentSelectedSongIndex = newIndex;
                  }*/ /*
                }
                */ /*else if (oldIndex > newIndex) {
                  if (currentSelectedSongIndex > oldIndex && currentSelectedSongIndex < newIndex) {
                    currentSelectedSongIndex += 1;
                  }
                   if (newIndex <= currentSelectedSongIndex) {
                    currentSelectedSongIndex += 1;
                    if (oldIndex == currentSelectedSongIndex) {
                      currentSelectedSongIndex = newIndex;
                    }
                  }
                }*/ /*

                final Song movedSong = widget.playlistName.removeAt(oldIndex);
                widget.songList.insert(
                  newIndex,
                  movedSong,
                );
              });*/
            },
            //buildDefaultDragHandles: false,
            physics: widget.physics,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemCount: HardcodedPlaylists().playlists[widget.playlistName].length,
            itemBuilder: (context, index) {
              return singleSongTile(index);
            },
          )
        : ListView.builder(
            physics: widget.physics,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemCount: HardcodedPlaylists().playlists[widget.playlistName].length,
            itemBuilder: (context, index) {
              return singleSongTile(index);
            },
          );
  }

  Widget singleSongTile(int index) {
    AudioProvider _provider = Provider.of<AudioProvider>(context, listen: false);
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      key: Key('$index'),
      onPressed: () {
        setState(() {
          //print('index: $index');
          _provider
              .loadPlaylist(widget.playlistName)
              .then((value) => _provider.seekTo(index))
              .then((value) => _provider.playPauseAudio(true));

          currentSelectedSongIndex = index;
        });
      },
      child: Container(
        height: 60,
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
                  image: AssetImage(
                      HardcodedPlaylists().playlists[widget.playlistName][index].coverImagePath),
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
                      HardcodedPlaylists().playlists[widget.playlistName][index].songName,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      HardcodedPlaylists().playlists[widget.playlistName][index].artist.artistName,
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
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
