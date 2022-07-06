import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/presentation_layer/screens/home/home_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/markets/markets_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/orders/orders_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/profile/profile_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/search/search_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/top_markets/top_markets_phone_screen.dart';
import 'package:martizoom/shared/components/app_icons/app_icons.dart';
import 'package:martizoom/shared/constants/constants.dart';
import '../../presentation_layer/screens/carts/carts_phone_screen.dart';

part 'main_page_phone_state.dart';

class MainPagePhoneCubit extends Cubit<MainPagePhoneState> {
  late final mainSubScreens;

  MainPagePhoneCubit() : super(MainPagePhoneInitial()) {
    mainSubScreens = [
      const HomePhoneScreen(),
      CartsPhoneScreen(),
      OrdersPhoneScreen(),
      ProfilePhoneScreen(),
    ];
  }

  static MainPagePhoneCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);

  int bottomNavBarCurrentIndex = 0;

  changeNavigationBottomBarIndex(int value) {
    bottomNavBarCurrentIndex = value;
    emit(ChangeBottomNavBar());
  }

  int homePageLevel = 0;

  changeHomePageLevel(int value) {
    mainSubScreens.removeAt(0);
    if (value == 0) {
      mainSubScreens.insert(0, const HomePhoneScreen());
    } else if (value == 1) {
      mainSubScreens.insert(0, TopMarketsPhoneScreen());
    } else if (value == 2) {
      mainSubScreens.insert(0, MarketsPhoneScreen());
    } else {
      mainSubScreens.insert(0, SearchPhoneScreen());
    }
    homePageLevel = value;
    emit(ChangeHomePageLevel());
  }

  final bottomNavItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: const Icon(AppIcons.gocery),
      label: appLocalization!.home,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.add_shopping_cart),
      label: appLocalization!.carts,
    ),
    BottomNavigationBarItem(
      icon: const Icon(AppIcons.order),
      label: appLocalization!.order,
    ),
    BottomNavigationBarItem(
      icon: const Icon(
        AppIcons.user,
      ),
      label: appLocalization!.profile,
    ),
  ];
}
