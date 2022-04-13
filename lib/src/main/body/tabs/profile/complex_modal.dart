import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ComplexModal extends StatefulWidget {
  const ComplexModal({Key key}) : super(key: key);

  @override
  _ComplexModalState createState() => _ComplexModalState();
}

class _ComplexModalState extends State<ComplexModal> {
  AudioPlayer _audioPlayer = AudioPlayer();

  File coverImagePath;

  @override
  void initState() {
    pickAudioFile();
    super.initState();
  }

  Future<void> pickAudioFile() async {
    FilePickerResult pickedAudioFile = await FilePicker.platform.pickFiles(type: FileType.audio);

    setState(() {
      if (pickedAudioFile != null) {
        File file = File(pickedAudioFile.files.single.path);

        _audioPlayer.setAudioSource(AudioSource.uri(file.uri));
        _audioPlayer.play();

        print('file uri: ${file.uri}');
      } else {
        print('result is: $pickedAudioFile : ${_audioPlayer.currentIndex}');
        return;
        // User canceled the picker
      }
    });
  }

  Future<void> pickCoverImage() async {
    FilePickerResult pickedImageFile = await FilePicker.platform.pickFiles(type: FileType.image);

    setState(() {
      if (pickedImageFile != null) {
        coverImagePath = File(pickedImageFile.files.single.path);
      } else {
        return;
        // User canceled the picker
      }
    });
  }

  @override
  Widget build(BuildContext rootContext) {
    return Material(
        child: Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (builderContext) => Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(rootContext).backgroundColor,
              leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  showCupertinoDialog(
                      context: rootContext,
                      builder: (BuildContext dialogContext) {
                        return CupertinoAlertDialog(
                          title: Text('Save as draft?'),
                          actions: <Widget>[
                            CupertinoButton(
                              child: Text('Save'),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pop();
                                Navigator.of(rootContext).pop();
                                //TODO: save as draft
                              },
                            ),
                            CupertinoButton(
                              child: Text('Delete'),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pop();
                                Navigator.of(rootContext).pop();
                              },
                            ),
                            CupertinoButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            ),
                          ],
                        );
                      });
                  //Navigator.of(rootContext).pop();
                },
              ),
              centerTitle: true,
              title: Text(
                'Release New Music',
                style: TextStyle(color: Colors.white),
              ),
              bottom: AppBar(
                elevation: 0,
                backgroundColor: Colors.grey[800],
                toolbarHeight: 100,
                centerTitle: true,
                shape: coverImagePath == null
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      )
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                title: _audioPlayer.currentIndex != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '0:00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Slider(value: 0, onChanged: (value) {}),
                                  Text(
                                    '0:00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                //set the audio player to null so that the current index will be null
                                _audioPlayer.dispose();
                                _audioPlayer = AudioPlayer();
                                print('currentindex : ${_audioPlayer.currentIndex}');
                              });
                            },
                            child: Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    : DashedButton(
                        onPressed: () {
                          setState(() {
                            pickAudioFile();
                          });
                        },
                        text: 'Upload song file',
                        //icon: Icons.audiotrack,
                        height: 50,
                      ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    coverImagePath == null
                        ? DashedButton(
                            onPressed: () {
                              setState(() {
                                pickCoverImage();
                              });
                            },
                            text: 'Upload a song cover',
                            icon: Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                              top: 15.0,
                              bottom: 35.0,
                              left: 35.0,
                              right: 35.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(5, 5),
                                  blurRadius: 5,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(5, 5),
                                    blurRadius: 5,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Image.file(
                                coverImagePath,
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    /*CupertinoButton(
                      onPressed: () {},
                      child: Container(
                        //margin: const EdgeInsets.all(15.0),
                        width: 150,
                        height: 150,
                        child: Card(
                          color: Colors.white12,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload,
                                color: Colors.white,
                              ),
                              Text('audio file'),
                            ],
                          ),
                        ),
                      ),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Song Title'),
                      ),
                    )
                  ],
                ),
              ),

              /*ListView(
                shrinkWrap: true,
                controller: ModalScrollController.of(context),
                children: ListTile.divideTiles(
                  context: rootContext,
                  tiles: List.generate(
                      100,
                      (index) => ListTile(
                            title: Text('Item'),
                            onTap: () {
                              Navigator.of(rootContext).push(
                                MaterialPageRoute(
                                  builder: (context) => CupertinoPageScaffold(
                                    navigationBar: CupertinoNavigationBar(
                                      middle: Text('New Page'),
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        MaterialButton(
                                          onPressed: () => Navigator.of(rootContext).pop(),
                                          child: Text('touch here'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                ).toList(),
              ),*/
            ),
          ),
        ),
      ),
    ));
  }
}

class DashedButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final double height;
  final Function onPressed;
  const DashedButton({Key key, @required this.text, this.icon, this.height = 150, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: DottedBorder(
        color: Colors.white54,
        strokeWidth: 3,
        radius: Radius.circular(10),
        dashPattern: [10, 5],
        customPath: (size) {
          return Path()
            ..moveTo(10, 0)
            ..lineTo(size.width - 10, 0)
            ..arcToPoint(Offset(size.width, 10), radius: Radius.circular(10))
            ..lineTo(size.width, size.height - 10)
            ..arcToPoint(Offset(size.width - 10, size.height), radius: Radius.circular(10))
            ..lineTo(10, size.height)
            ..arcToPoint(Offset(0, size.height - 10), radius: Radius.circular(10))
            ..lineTo(0, 10)
            ..arcToPoint(Offset(10, 0), radius: Radius.circular(10));
        },
        child: Container(
          //margin: const EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
          height: height,
          child: Card(
            color: Colors.white12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon == null ? Container() : icon,
                Text(
                  text,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
