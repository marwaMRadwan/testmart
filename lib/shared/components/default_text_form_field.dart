import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  Function? onChange;
  Function? onTap;
  bool isPassword;
  Function? validate;
  final String label;
  IconData? prefix;
  IconData? suffix;
  Function? prefixPressed;
  Function? suffixPressed;
  bool isClickable;
  bool readOnly;
  int? maxLines;
  int? minLines;

  DefaultTextFormField({
    Key? key,
    required this.controller,
    required this.type,
    this.onChange,
    this.onTap,
    this.isPassword = false,
    this.validate,
    required this.label,
    this.prefix,
    this.suffix,
    this.prefixPressed,
    this.suffixPressed,
    this.isClickable = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: isPassword,
      enabled: isClickable,
      // onFieldSubmitted: (value) {
      //   if (onSubmit != null) onSubmit(value);
      // },
      onChanged: (value) {
        if (onChange != null) onChange!(value);
      },
      onTap: () {
        if (onTap != null) onTap!();
      },
      validator: (value) {
        if (validate != null) return validate!(value);
        return null;
      },
      readOnly: readOnly,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: label,
        labelText: label,
        prefixIcon: prefix != null
            ? IconButton(
                onPressed: () {
                  if (prefixPressed != null) prefixPressed!();
                },
                icon: Icon(
                  prefix,
                ),
              )
            : null,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  if (suffixPressed != null) suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
    );
  }
}
