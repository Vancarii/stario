import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stario/src/widgets/custom_rounded_textfield.dart';

class SearchPage extends StatefulWidget {
  final Function(bool) searchBarTapped;

  const SearchPage({Key key, this.searchBarTapped}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool canClear = false;

  FocusNode searchBarFocusNode = FocusNode();

  bool isFocused = false;

  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    searchBarFocusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    searchBarFocusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  CupertinoButton(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      searchBarFocusNode.unfocus();
                      widget.searchBarTapped(false);
                    },
                  ),
                  Expanded(
                    child: CustomRoundedTextField(
                      node: searchBarFocusNode,
                      controller: _searchTextController,
                      labelText: 'Search',
                      //labelTextStyle: TextStyle(color: Colors.white.withOpacity(_fadeSearchLabelAnimation.value)),
                      onTextChanged: (value) {
                        setState(() {
                          if (value == '') {
                            canClear = false;
                          } else {
                            canClear = true;
                          }
                        });
                      },
                      endIcon: canClear == true
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _searchTextController.clear();
                                  canClear = false;
                                });
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.grey,
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
