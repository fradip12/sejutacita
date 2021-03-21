import 'package:flutter/material.dart';

class TextFormFieldBorder extends StatelessWidget {
  final Key key;
  final TextInputType keyboardType;
  final bool isSecure;
  final Widget prefixIcon;
  final Widget suffix;
  final int maxLines;
  final String hintText;
  final void Function(String) onChanged;
  final String Function(String) validatorFunction;
  final TextEditingController globControl;
  final GlobalKey<FormFieldState> globKey;
  final Color borderColor;
  final double edited;
  final FocusNode focus;

  const TextFormFieldBorder({
    this.key,
    @required this.isSecure,
    @required this.onChanged,
    this.validatorFunction,
    this.prefixIcon,
    this.keyboardType,
    @required this.globControl,
    @required this.globKey,
    this.maxLines,
    this.hintText,
    this.borderColor,
    this.suffix,
    this.edited,
    this.focus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: focus != null
          ? focus.hasFocus
              ? 10.0
              : 2.0
          : 2.0,
      shadowColor: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
          key: globKey,
          focusNode: focus ?? null,
          maxLines: maxLines ?? 1,
          controller: globControl,
          obscureText: isSecure,
          keyboardType: keyboardType ?? TextInputType.text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintMaxLines: 1,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 15, top: 15, right: 15),
            hintText: hintText,
            alignLabelWithHint: true,
            isDense: true,
            hintStyle: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            prefixIcon: prefixIcon,
            suffixIcon: suffix ?? null,
          ),
          onChanged: onChanged ?? (String val) {},
          validator: validatorFunction ??
              (val) {
                if (val.isEmpty) {
                  return "Mohon isi dengan benar!";
                } else
                  return null;
              }),
    );
  }
}