import 'package:flutter/material.dart';

class DefaultTabletAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Widget? leadingButtons;
  final Function? backButtonPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;

  DefaultTabletAppBar(
      {Key? key,
      required this.title,
      this.leadingButtons,
      this.backButtonPressed,
      this.actions,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      leading: FittedBox(
        fit: BoxFit.contain,
        child: leadingButtons ??
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_sharp),
              onPressed: () {
                if (backButtonPressed != null) {
                  backButtonPressed!();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
      ),
      title: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          title,
        ),
      ),
      actions: actions ??
          ([
            // if (Platform.isIOS)
            //   IconButton(
            //     icon: const Icon(
            //       Icons.arrow_forward_ios_sharp,
            //       size: 30.0,
            //     ),
            //     onPressed: () {
            //       if (backButtonPressed != null) {
            //         backButtonPressed!();
            //       } else {
            //         // currentDrawerItem = DrawerItem.home;
            //         // navigateAndFinishTo(context: context, screen: const HomeScreen());
            //       }
            //     },
            //   )
          ]),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return const Size.fromHeight(
      60.0,
    );
  }
}
