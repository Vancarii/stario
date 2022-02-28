import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewReleasePage extends StatefulWidget {
  const NewReleasePage({Key key}) : super(key: key);

  @override
  _NewReleasePageState createState() => _NewReleasePageState();
}

class _NewReleasePageState extends State<NewReleasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            )),
        title: Text("Release New Music"),
      ),
    );
  }
}
