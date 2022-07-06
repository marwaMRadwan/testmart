import 'package:flutter/material.dart';

import '../styles/colors.dart';

class DefaultButton extends StatelessWidget {
  double width;

  double height;

  Color backgroundColor;

  // bool isUpperCase;
  bool disable;

  double radius;

  double textFontSize;

  final Function function;
  final String text;

  DefaultButton({
    Key? key,
    this.width = double.infinity,
    this.height = 50,
    this.backgroundColor = defaultColor,
    // this.isUpperCase = true,
    this.radius = 1.0,
    this.textFontSize = 18.0,
    required this.function,
    required this.text,
    this.disable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: !disable
            ? () {
                function();
              }
            : null,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            // isUpperCase ? text.toUpperCase() :

            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: backgroundColor,
      ),
    );
  }
}
