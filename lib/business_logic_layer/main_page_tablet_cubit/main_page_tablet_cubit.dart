import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/presentation_layer/screens/markets/markets_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/orders/orders_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/search/search_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/top_markets/top_markets_tablet_screen.dart';
import '../../presentation_layer/screens/carts/carts_tablet_screen.dart';
import '../../presentation_layer/screens/home/home_tablet_screen.dart';
import '../../presentation_layer/screens/profile/profile_tablet_screen.dart';
import '../../shared/components/app_icons/app_icons.dart';
import '../../shared/constants/constants.dart';

part 'main_page_tablet_state.dart';

class MainPageTabletCubit extends Cubit<MainPageTabletState> {
  late final mainSubScreens;

  MainPageTabletCubit() : super(MainPageTabletInitial()) {
    mainSubScreens = [
      const HomeTabletScreen(),
      CartsTabletScreen(),
      OrdersTabletScreen(),
      ProfileTabletScreen(),
    ];
  }

  static MainPageTabletCubit get(context, {bool listen = false}) =>
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
      mainSubScreens.insert(0, const HomeTabletScreen());
    } else if (value == 1) {
      mainSubScreens.insert(0, TopMarketsTabletScreen());
    } else if (value == 2) {
      mainSubScreens.insert(0, const MarketsTabletScreen());
    } else {
      mainSubScreens.insert(0, SearchTabletScreen());
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
