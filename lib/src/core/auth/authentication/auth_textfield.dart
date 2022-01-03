import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatefulWidget {
  final FocusNode node;
  final bool password;
  final int maxLines;
  final int minLines;
  final TextInputAction keyboardAction;
  final EdgeInsetsGeometry padding;
  final String labelText;
  final String errorText;
  final Icon startIcon;
  final IconButton endIcon;
  final TextInputType keyboard;
  final Color focusIconColor;
  final Color cursorColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final TextEditingController controller;
  final Function(String) onTextChanged;
  final Function(String) onSubmit;

  const AuthTextField({
    Key key,
    this.node,
    this.password = false,
    this.maxLines = 1,
    this.minLines,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0),
    this.labelText,
    this.startIcon,
    this.endIcon,
    this.keyboardAction = TextInputAction.done,
    this.keyboard = TextInputType.multiline,
    this.focusIconColor = Colors.white,
    this.cursorColor = Colors.white,
    this.focusedBorderColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.controller,
    this.onTextChanged,
    this.onSubmit,
    this.errorText,
  }) : super(key: key);

  @override
  _AuthTextFieldState createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool hiddenPassword;

  @override
  void initState() {
    hiddenPassword = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(primary: widget.focusIconColor)),
        child: TextFormField(
          obscureText: hiddenPassword,
          textInputAction: widget.keyboardAction,
          focusNode: widget.node,
          onChanged: widget.onTextChanged,
          controller: widget.controller,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          keyboardType: widget.keyboard,
          cursorColor: widget.cursorColor,
          textCapitalization: TextCapitalization.sentences,
          maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
          onFieldSubmitted: widget.onSubmit,
          decoration: InputDecoration(
            errorText: widget.errorText,
            fillColor: Colors.grey.withOpacity(0.2),
            filled: true,
            contentPadding: EdgeInsets.only(left: 15, bottom: 15),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: widget.labelText,
            prefixIcon: widget.startIcon,
            suffixIcon: widget.password == true
                ? hiddenPassword == true
                    ? IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            hiddenPassword = false;
                            print('hiddeneee');
                          });
                        },
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            hiddenPassword = true;
                          });
                        },
                        icon: Icon(Icons.visibility_off))
                : null,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.focusedBorderColor,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor,
                ),
                borderRadius: BorderRadius.circular(30.0)),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor,
                ),
                borderRadius: BorderRadius.circular(30.0)),
          ),
        ),
      ),
    );
  }
}
