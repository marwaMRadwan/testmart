import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/home_markets_cubit/home_markets_cubit.dart';
import 'package:martizoom/business_logic_layer/home_top_markets_cubit/home_top_markets_cubit.dart';
import 'package:martizoom/business_logic_layer/main_page_tablet_cubit/main_page_tablet_cubit.dart';
import 'package:martizoom/business_logic_layer/user_data_cubit/user_data_cubit.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/widgets/market/market_tablet_widget.dart';
import 'package:martizoom/presentation_layer/widgets/search/search_tablet_widget.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';

class HomeTabletScreen extends StatefulWidget {
  const HomeTabletScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabletScreen> createState() => _HomeTabletScreenState();
}

class _HomeTabletScreenState extends State<HomeTabletScreen> {
  late final HomeTopMarketsCubit _topMarketsCubit;
  late final HomeMarketsCubit _marketsCubit;
  late final MainPageTabletCubit mainPageCubit;

  @override
  void initState() {
    // TODO: implement initState
    _topMarketsCubit = HomeTopMarketsCubit.get(context);
    _marketsCubit = HomeMarketsCubit.get(context);
    mainPageCubit = MainPageTabletCubit.get(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, userDataState) {
        return BuildCondition(
          condition: userDataState is GetUserDataLoadingState,
          builder: (context) => LoadingScreen(),
          fallback: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SearchTabletWidget(
                    onPressed: () {
                      mainPageCubit.changeHomePageLevel(3);
                    },
                  ),
                  BlocBuilder<HomeTopMarketsCubit, HomeTopMarketsState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  appLocalization!.topMarkets,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    mainPageCubit.changeHomePageLevel(1);
                                  },
                                  child: Text(
                                    '${appLocalization!.seeAll} (${_topMarketsCubit.topMarketsCount})',
                                    style: const TextStyle(
                                        color: Color(0xFF939394),
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BuildCondition(
                              condition:
                                  state is GetHomeTopMarketsDataErrorState,
                              builder: (_) => DefaultErrorWidget(
                                    error: (state
                                            as GetHomeTopMarketsDataErrorState)
                                        .error,
                                  ),
                              fallback: (context) {
                                return BuildCondition(
                                    condition: state
                                        is GetHomeTopMarketsDataEmptyState,
                                    builder: (_) => DefaultEmptyItemsText(
                                          itemsName:
                                              appLocalization!.topMarkets,
                                        ),
                                    fallback: (context) {
                                      return SizedBox(
                                        height: setHeightValue(
                                          portraitValue: 0.2,
                                          landscapeValue: 0.34,
                                        ),
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0,
                                              horizontal: _topMarketsCubit
                                                          .topMarkets.length <
                                                      4
                                                  ? 25.0
                                                  : 15.0),
                                          itemBuilder: (context, index) =>
                                              MarketTabletWidget(
                                            topMarketModel: _topMarketsCubit
                                                .topMarkets[index],
                                          ),
                                          separatorBuilder:
                                              (context, int index) =>
                                                  const SizedBox(
                                            width: 10.0,
                                          ),
                                          itemCount: _topMarketsCubit
                                                      .topMarkets.length <
                                                  12
                                              ? _topMarketsCubit
                                                  .topMarkets.length
                                              : 12,
                                        ),
                                      );
                                    });
                              }),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<HomeMarketsCubit, HomeMarketsState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  appLocalization!.markets,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // navigateTo(
                                    //     context: context,
                                    //     screen: MarketsScreen());
                                    mainPageCubit.changeHomePageLevel(2);
                                  },
                                  child: Text(
                                    '${appLocalization!.seeAll} (${_marketsCubit.marketsCount})',
                                    style: const TextStyle(
                                        color: Color(0xFFce0900),
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BuildCondition(
                              condition: state is GetHomeMarketsDataErrorState,
                              builder: (_) => DefaultErrorWidget(
                                  error: (state as GetHomeMarketsDataErrorState)
                                      .error),
                              fallback: (context) {
                                return BuildCondition(
                                    condition:
                                        state is GetHomeMarketsDataEmptyState,
                                    builder: (_) => DefaultEmptyItemsText(
                                        itemsName: appLocalization!.markets),
                                    fallback: (context) {
                                      return Wrap(
                                        children: _marketsCubit.markets
                                            .map(
                                              (market) => MarketTabletWidget(
                                                topMarketModel: market,
                                              ),
                                            )
                                            .toList(),
                                        spacing: 10.0,
                                        runSpacing: 20.0,
                                      );
                                    });
                              }),
                          const SizedBox(
                            height: 15.0,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
