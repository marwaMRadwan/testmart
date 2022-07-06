import 'package:flutter/material.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/constants/constants.dart';

class DefaultErrorWidget extends StatelessWidget {
  final error;
  Function? onPressed;

  DefaultErrorWidget({
    Key? key,
    required this.error,
    this.onPressed,
  }) : super(key: key);

  var _screenWidth;

  var _screenHeight;

  var _isLandscape;

  var currentFocus;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Align(
      alignment: Alignment.topCenter,
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                getErrorMessage(error),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 22.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              if (onPressed != null)
                DefaultButton(
                  width: 100.0,
                  height: 40.0,
                  function: onPressed!,
                  text: appLocalization!.tryAgain,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
