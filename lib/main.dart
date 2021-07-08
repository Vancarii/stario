import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stario/src/main/song_bottom_sheet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(StarioApp());
}

class StarioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        primaryColorLight: Color(0xfff222222),
        accentColor: Color(0xfffdc143c),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      home: SongBottomSheet(),
    );
  }
}

//grey = Color(0xfff333333),

// offblack = Color(0xfff222222),
