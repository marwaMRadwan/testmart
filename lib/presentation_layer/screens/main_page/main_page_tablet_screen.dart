import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/home_markets_cubit/home_markets_cubit.dart';
import 'package:martizoom/business_logic_layer/home_top_markets_cubit/home_top_markets_cubit.dart';
import 'package:martizoom/business_logic_layer/main_page_tablet_cubit/main_page_tablet_cubit.dart';
import 'package:martizoom/business_logic_layer/user_data_cubit/user_data_cubit.dart';
import 'package:martizoom/presentation_layer/screens/login/login_tablet_screen.dart';
import 'package:martizoom/shared/constants/constants.dart';

import '../../../business_logic_layer/radio_button_cubit/radio_button_cubit.dart';
import '../../../business_logic_layer/update_user_view_settings_cubit/update_user_view_settings_cubit.dart';
import '../../../shared/components/default_button.dart';
import '../../../shared/styles/colors.dart';

class MainPageTabletScreen extends StatefulWidget {
  final bool showViewDialog;

  MainPageTabletScreen({Key? key, required this.showViewDialog})
      : super(key: key);

  @override
  State<MainPageTabletScreen> createState() => _MainPageTabletScreenState();
}

class _MainPageTabletScreenState extends State<MainPageTabletScreen> {
  late final HomeTopMarketsCubit _homeMarketsCubit;
  late final HomeMarketsCubit _homeTopMarketsCubit;

  late final UserDataCubit _userDataCubit;

  @override
  void initState() {
    _userDataCubit = UserDataCubit.get(context);
    _homeMarketsCubit = HomeTopMarketsCubit.get(context);
    _homeTopMarketsCubit = HomeMarketsCubit.get(context);

    /// prepare top market cubit
    /// by getting it the zone id from
    /// the user data cubit
    _homeMarketsCubit.zoneId = _userDataCubit.appUser?.defaultAddress?.zoneId;
    _homeMarketsCubit.getHomeTopMarkets();
    _homeTopMarketsCubit.getHomeMarkets();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.showViewDialog) _showViewsDialog(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MainPageTabletCubit _mainPageCubit = MainPageTabletCubit.get(context);
    return BlocConsumer<UserDataCubit, UserDataState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BlocConsumer<MainPageTabletCubit, MainPageTabletState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
              body: _mainPageCubit
                  .mainSubScreens[_mainPageCubit.bottomNavBarCurrentIndex],
              bottomNavigationBar: SizedBox(
                height: 70.0,
                child: BottomNavigationBar(
                  currentIndex: _mainPageCubit.bottomNavBarCurrentIndex,
                  onTap: (value) {
                    if (value == 0 || isLoggedIn) {
                      _mainPageCubit.changeHomePageLevel(0);
                      _mainPageCubit.changeNavigationBottomBarIndex(
                        value,
                      );
                    } else {
                      navigateTo(
                        context: context,
                        screen: LoginTabletScreen(),
                      );
                    }
                  },
                  items: _mainPageCubit.bottomNavItems,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showViewsDialog(BuildContext context) {
    final RadioButtonCubit _radioButtonCubit = RadioButtonCubit();
    _radioButtonCubit.buttonValue = viewType;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        title: Text(
          appLocalization!.chooseViewType,
          style: const TextStyle(
            color: defaultColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        children: [
          BlocConsumer<UpdateUserViewSettingsCubit,
              UpdateUserViewSettingsState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is UpdateUserViewSettingsSuccessState) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: setWidthValue(
                    portraitValue: 0.08,
                    landscapeValue: 0.02,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  width: setWidthValue(
                    portraitValue: 0.3,
                    landscapeValue: 0.2,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: [
                      BlocProvider(
                        create: (context) => _radioButtonCubit,
                        child: BlocConsumer<RadioButtonCubit, RadioButtonState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            return Column(
                              children: ['3d', '2d']
                                  .map(
                                    (type) => Column(
                                      children: [
                                        RadioListTile<String>(
                                          title: Text(type),
                                          value: type,
                                          groupValue:
                                              _radioButtonCubit.buttonValue,
                                          onChanged: (value) {
                                            _radioButtonCubit
                                                .changeRadioButtonValue(value);
                                          },
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ),
                      BuildCondition(
                          condition:
                              state is UpdateUserViewSettingsLoadingState,
                          builder: (_) => const CircularProgressIndicator(),
                          fallback: (context) {
                            return Column(
                              children: [
                                DefaultButton(
                                  function: () {
                                    UpdateUserViewSettingsCubit.get(context)
                                        .updateUserViewSettings(
                                            type:
                                                _radioButtonCubit.buttonValue);
                                  },
                                  text: appLocalization!.update,
                                  radius: 10.0,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                DefaultButton(
                                  function: () {
                                    Navigator.pop(context);
                                  },
                                  text: appLocalization!.skip,
                                  radius: 10.0,
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
