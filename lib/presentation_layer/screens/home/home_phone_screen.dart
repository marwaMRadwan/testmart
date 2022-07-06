import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/home_markets_cubit/home_markets_cubit.dart';
import 'package:martizoom/business_logic_layer/home_top_markets_cubit/home_top_markets_cubit.dart';
import 'package:martizoom/business_logic_layer/main_page_phone_cubit/main_page_phone_cubit.dart';
import 'package:martizoom/business_logic_layer/offers_cubit/offers_cubit.dart';
import 'package:martizoom/business_logic_layer/user_data_cubit/user_data_cubit.dart';
import 'package:martizoom/presentation_layer/screens/category/category_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/widgets/market/market_phone_widget.dart';
import 'package:martizoom/presentation_layer/widgets/search/search_phone_widget.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';

class HomePhoneScreen extends StatefulWidget {
  const HomePhoneScreen({Key? key}) : super(key: key);

  @override
  State<HomePhoneScreen> createState() => _HomePhoneScreenState();
}

class _HomePhoneScreenState extends State<HomePhoneScreen> {
  late final HomeTopMarketsCubit _topMarketsCubit;
  late final HomeMarketsCubit _marketsCubit;
  late final MainPagePhoneCubit mainPageCubit;

  @override
  void initState() {
    // TODO: implement initState
    _topMarketsCubit = HomeTopMarketsCubit.get(context);
    _marketsCubit = HomeMarketsCubit.get(context);
    mainPageCubit = MainPagePhoneCubit.get(context);
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
                  SearchPhoneWidget(
                    onPressed: () {
                      mainPageCubit.changeHomePageLevel(3);
                    },
                  ),
                  BlocBuilder<HomeTopMarketsCubit, HomeTopMarketsState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          BlocConsumer<OffersCubit, OffersState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              return BuildCondition(
                                  condition: state is GetOffersDataErrorState,
                                  builder: (_) => DefaultErrorWidget(
                                      error: (state as GetOffersDataErrorState)
                                          .error),
                                  fallback: (context) {
                                    return BuildCondition(
                                        condition:
                                            state is GetOffersDataLoadingState,
                                        builder: (_) => Container(),
                                        fallback: (context) {
                                          return BuildCondition(
                                              condition: state
                                                  is GetOffersDataEmptyState,
                                              builder: (_) =>
                                                  DefaultEmptyItemsText(
                                                    itemsName: appLocalization!.offers,
                                                  ),
                                              fallback: (context) {
                                                final offers =
                                                    OffersCubit.get(context)
                                                        .offers;
                                                return CarouselSlider.builder(
                                                  itemCount: offers.length,
                                                  itemBuilder: (BuildContext
                                                              context,
                                                          int itemIndex,
                                                          int pageViewIndex) =>
                                                      InkWell(
                                                    onTap: () {
                                                      navigateTo(
                                                        context: context,
                                                        screen:
                                                            CategoryPhoneScreen(
                                                          marketId: offers[
                                                                      itemIndex]
                                                                  .marketId ??
                                                              '0',
                                                          categoryName: offers[
                                                                      itemIndex]
                                                                  .categoriesName ??
                                                              ' ',
                                                          categoryId: offers[
                                                                      itemIndex]
                                                                  .categoryId ??
                                                              '0',
                                                          sceneId: offers[
                                                                      itemIndex]
                                                                  .themeId ??
                                                              '0',
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: setWidthValue(
                                                        portraitValue: 1.0,
                                                        landscapeValue: 0.7,
                                                      ),
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Image.network(
                                                        OffersCubit.get(context)
                                                                .offers[
                                                                    itemIndex]
                                                                .imagePath ??
                                                            '',
                                                        fit: BoxFit.fill,
                                                        errorBuilder:
                                                            (_, __, ___) =>
                                                                Container(),
                                                      ),
                                                    ),
                                                  ),
                                                  options: CarouselOptions(
                                                    height: setHeightValue(
                                                      portraitValue: 0.16,
                                                      landscapeValue: 0.24,
                                                    ),
                                                    autoPlay: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    initialPage: 0,
                                                    reverse: false,
                                                    enlargeCenterPage: true,
                                                  ),
                                                );
                                              });
                                        });
                                  });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  appLocalization!.topMarkets,
                                  style: const TextStyle(
                                    color: Color(0xFFce0900),
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
                                        color: Color(0xFFce0900),
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
                                          landscapeValue: 0.35,
                                        ),
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0,
                                              horizontal:  15.0),
                                          itemBuilder: (context, index) =>
                                              MarketPhoneWidget(
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
                                    color: Color(0xFFce0900),
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
                                              (market) => MarketPhoneWidget(
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
