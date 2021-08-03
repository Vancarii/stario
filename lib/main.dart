import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stario/src/main/song_bottom_sheet.dart';
import 'package:stario/src/services/audio/audio_player_service.dart';
import 'package:stario/src/services/audio/just_audio_player.dart';
import 'package:stario/src/services/playlists/hardcoded_collection_songs.dart';
import 'package:stario/src/services/playlists/playlists_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(StarioApp());
}

class StarioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xfff17181c),
    ));
    return MultiProvider(
      providers: [
        Provider<PlaylistsService>(
          create: (_) => HardcodedPlaylistsService(),
        ),
        Provider<AudioPlayerService>(
          create: (_) => JustAudioPlayer(),
          dispose: (_, value) {
            (value as JustAudioPlayer).dispose();
          },
        ),
        /*ChangeNotifierProvider(
          create: (BuildContext context) => AudioProvider(),
        ),*/
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,

          //custom blue theme
/*        scaffoldBackgroundColor: Color(0xfff132630),
          primaryColor: Color(0xfff1b3845),
          primaryColorDark: Color(0xfff1C00ff00),
          primaryColorLight: Color(0xfff3a5461),
          accentColor: Color(0xfff448e96),*/
          accentColor: Color(0xfff448e96),

          //Discord Theme
          scaffoldBackgroundColor: Color(0xfff17181c),
          primaryColor: Color(0xfff35383f),
          primaryColorDark: Color(0xfff1C00ff00),
          primaryColorLight: Color(0xfff3a5461),
          //accentColor: Color(0xfff4e5d94),

          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        home: SongBottomSheet(),
      ),
    );
  }
}

//grey = Color(0xfff333333),

// offblack = Color(0xfff222222),

// teal = Color(0xfff00ffa0),

// Carmine = Color(0xfffff0038),

// pink = Color(0xfffed5752),

//purplel = Color(0xfff593FA9),
