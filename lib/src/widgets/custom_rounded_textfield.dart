import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomRoundedTextField extends StatelessWidget {
  final FocusNode node;
  final bool password;
  final int maxLines;
  final int minLines;
  final TextInputAction keyboardAction;
  final EdgeInsetsGeometry padding;
  final String labelText;
  final Icon startIcon;
  final IconButton endIcon;
  final TextInputType keyboard;
  final Color focusIconColor;
  final Color cursorColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final TextEditingController controller;
  final Function(String) onTextChanged;
  final Function(String) validator;
  final Function(String) onSubmit;
  final TextStyle labelTextStyle;
  final Widget prefix;
  final String errorText;
  final List<TextInputFormatter> formatter;

  const CustomRoundedTextField({
    Key key,
    this.node,
    this.password = false,
    this.maxLines = 1,
    this.minLines,
    this.padding = const EdgeInsets.all(0.0),
    this.labelText,
    this.startIcon,
    this.endIcon,
    this.keyboardAction = TextInputAction.done,
    this.keyboard = TextInputType.text,
    this.focusIconColor = Colors.white,
    this.cursorColor = Colors.white,
    this.focusedBorderColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.controller,
    this.onTextChanged,
    this.onSubmit,
    this.labelTextStyle = const TextStyle(color: Colors.white54),
    this.prefix,
    this.errorText,
    this.validator,
    this.formatter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Theme(
        data: Theme.of(context)
            .copyWith(colorScheme: Theme.of(context).colorScheme.copyWith(primary: focusIconColor)),
        child: TextFormField(
          inputFormatters: formatter,
          obscureText: password,
          textInputAction: keyboardAction,
          focusNode: node,
          onChanged: onTextChanged,
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          keyboardType: keyboard,
          cursorColor: cursorColor,
          textCapitalization: TextCapitalization.none,
          maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
          onFieldSubmitted: onSubmit,
          validator: validator,
          decoration: InputDecoration(
            errorText: errorText,
            prefix: prefix,
            fillColor: Colors.white12,
            filled: true,
            isDense: true,
            contentPadding: EdgeInsets.only(
              left: 15,
              top: 15,
              bottom: 15,
            ),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: labelText,
            labelStyle: labelTextStyle,
            prefixIcon: startIcon,
            suffixIcon: endIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusedBorderColor,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(30.0)),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(30.0)),
          ),
        ),
      ),
    );
  }
}
