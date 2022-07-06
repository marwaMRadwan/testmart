import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:martizoom/presentation_layer/screens/choose_language/choose_language_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/main_page/main_page_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/on_board/on_board_phone_screen.dart';
import 'package:martizoom/shared/network/local/cache_helper.dart';

import '../../shared/constants/constants.dart';

class BasePhonePage extends StatefulWidget {
  final bool showViewDialog;

  BasePhonePage({Key? key, required this.showViewDialog}) : super(key: key);

  @override
  State<BasePhonePage> createState() => _BasePhonePageState();
}

class _BasePhonePageState extends State<BasePhonePage> {
  @override
  @override
  Widget build(BuildContext context) {
    appLocalization = AppLocalizations.of(context);

    /// this variable is stored in the device storage
    /// and get it for deciding show the onboard screen
    /// when the app is opened in the first time
    /// after install it
    bool? isBoard = CacheHelper.getData(key: 'isBoard');

    /// this variable is stored in the device storage
    /// and get it for deciding show the languages and
    /// countries screen when the app is opened in the first time
    /// for this device
    bool? isInstalled = CacheHelper.getData(key: 'isInstalled');
    return isInstalled == null
        ? ChooseLanguagePhoneScreen(
            showViewDialog: widget.showViewDialog,
          )
        : isBoard == null
            ? OnBoardPhoneScreen(
                showViewDialog: widget.showViewDialog,
              )
            : MainPagePhoneScreen(
                showViewDialog: widget.showViewDialog,
              );
  }
}
