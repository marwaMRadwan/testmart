import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:martizoom/presentation_layer/screens/choose_language/choose_language_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/main_page/main_page_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/on_board/on_board_tablet_screen.dart';
import 'package:martizoom/shared/network/local/cache_helper.dart';

import '../../shared/constants/constants.dart';

class BaseTabletPage extends StatefulWidget {
  final bool showViewDialog;

  BaseTabletPage({Key? key, required this.showViewDialog}) : super(key: key);

  @override
  State<BaseTabletPage> createState() => _BaseTabletPageState();
}

class _BaseTabletPageState extends State<BaseTabletPage> {
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
        ? ChooseLanguageTabletScreen(
            showViewDialog: widget.showViewDialog,
          )
        : isBoard == null
            ? OnBoardTabletScreen(
                showViewDialog: widget.showViewDialog,
              )
            : MainPageTabletScreen(
                showViewDialog: widget.showViewDialog,
              );
  }
}
