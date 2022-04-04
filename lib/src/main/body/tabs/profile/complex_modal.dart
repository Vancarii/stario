import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ComplexModal extends StatelessWidget {
  const ComplexModal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext rootContext) {
    return Material(
        child: Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (builderContext) => Builder(
          builder: (context) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
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
                middle: Text(
                  'Release New Music',
                  style: TextStyle(color: Colors.white),
                )),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DashedButton(
                      text: 'Upload a song cover',
                      icon: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                    DashedButton(
                      text: 'Upload song file',
                      //icon: Icons.audiotrack,
                      height: 50,
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
  const DashedButton({Key key, @required this.text, this.icon, this.height = 150})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {},
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
