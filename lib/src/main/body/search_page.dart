import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stario/src/widgets/custom_rounded_textfield.dart';

class SearchPage extends StatefulWidget {
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
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          searchBarFocusNode.unfocus();
                          Navigator.pop(context);
                        });
                      }),
                  Expanded(
                    child: CustomRoundedTextField(
                      node: searchBarFocusNode,
                      keyboard: TextInputType.text,
                      controller: _searchTextController,
                      maxLines: 1,
                      padding: const EdgeInsets.all(0.0),
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
