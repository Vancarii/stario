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
                  'New Release Music',
                  style: TextStyle(color: Colors.white),
                )),
            child: SafeArea(
              bottom: false,
              child: ListView(
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
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
