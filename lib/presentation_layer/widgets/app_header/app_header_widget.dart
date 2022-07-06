import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:martizoom/presentation_layer/screens/about_app/about_app_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/about_app/about_app_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/carts/carts_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/carts/carts_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/notifications/notifications_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/notifications/notifications_tablet_screen.dart';
import 'package:martizoom/shared/constants/constants.dart';

class AppHeaderWidget extends StatelessWidget {
  final double height;
  final String? title;
  final bool showCartButton;

  const AppHeaderWidget(
      {Key? key, required this.height, this.title, this.showCartButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: const Color(0xFFce0900),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: setHeightValue(
              portraitValue: 0.011,
              landscapeValue: 0.02,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Marti Zoom',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isLoggedIn
                    ? Row(
                        children: [
                          if (showCartButton)
                            IconButton(
                              onPressed: () async {
                                if (isLoggedIn) {
                                  if (await isTablet()) {
                                    navigateTo(
                                      context: context,
                                      screen: CartsTabletScreen(
                                          showAppHeader: false),
                                    );
                                  } else {
                                    navigateTo(
                                        context: context,
                                        screen: CartsPhoneScreen(
                                            showAppHeader: false));
                                  }
                                }
                              },
                              icon: const Icon(
                                Icons.add_shopping_cart_sharp,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                          IconButton(
                            onPressed: () async {
                              if (isLoggedIn) {
                                if (await isTablet()) {
                                  navigateTo(
                                      context: context,
                                      screen:
                                          const NotificationsTabletScreen());
                                } else {
                                  navigateTo(
                                      context: context,
                                      screen: const NotificationsPhoneScreen());
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.add_alert_rounded,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : IconButton(
                        onPressed: () async {
                          if (await isTablet()) {
                            navigateTo(
                                context: context,
                                screen: const AboutAppTabletScreen());
                          } else {
                            navigateTo(
                                context: context,
                                screen: const AboutAppPhoneScreen());
                          }
                        },
                        icon: const Icon(
                          Icons.question_mark,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
              ],
            ),
          ),
          title != null
              ? Row(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    Text(
                      '$title',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
