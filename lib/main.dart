import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stario/src/core/auth/authentication_page.dart';
import 'package:stario/src/firebase_functions/firebase_functions.dart';
import 'package:stario/src/main/song_bottom_sheet.dart';
import 'package:stario/src/provider/audio_provider.dart';
import 'package:stario/src/shared_prefs/shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // Initialize Firebase
  await Firebase.initializeApp();

  //initializes shared preferences
  await SharedPrefs.init();

  firebaseFunctions.init();

  runApp(StarioApp());
}

class StarioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Color(0xfff17181c),
      systemNavigationBarColor: Color(0xfff17181c),
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AudioProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,

          //so that the background for PageTransitionSwitcher isnt greyed out in the auth page
          canvasColor: Colors.transparent,

          //custom blue theme
/*        scaffoldBackgroundColor: Color(0xfff132630),
              primaryColor: Color(0xfff1b3845),
              primaryColorDark: Color(0xfff1C00ff00),
              primaryColorLight: Color(0xfff3a5461),
              accentColor: Color(0xfff448e96),*/
          accentColor: Color(0xfff448e96),
          backgroundColor: Color(0xfff17181c),
          //Discord Theme
          scaffoldBackgroundColor: Color(0xfff17181c),
          primaryColor: Color(0xfff35383f),
          primaryColorDark: Color(0xfff1C00ff00),
          primaryColorLight: Color(0xfff3a5461),
          //accentColor: Color(0xfff4e5d94),

          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        home: SharedPrefs.instance.username == null ? AuthenticationPage() : SongBottomSheet(),
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
