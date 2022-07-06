import 'package:flutter/material.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/styles/colors.dart';

import 'default_button.dart';

class DefaultEmptyItemsText extends StatelessWidget {
  final String itemsName;
  final Function? onPressed;

  DefaultEmptyItemsText({Key? key, required this.itemsName, this.onPressed})
      : super(key: key);

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
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 15.0),
          child: Column(
            children: [
              Text(
                languageCode == 'en'
                    ? '${appLocalization!.no} $itemsName ${appLocalization!.found}'
                    : '${appLocalization!.no} ${appLocalization!.found} $itemsName',
                style: const TextStyle(
                  color: defaultColor,
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
