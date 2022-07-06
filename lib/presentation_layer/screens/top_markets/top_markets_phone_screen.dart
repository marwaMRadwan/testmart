import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/main_page_phone_cubit/main_page_phone_cubit.dart';
import 'package:martizoom/business_logic_layer/top_markets_cubit/top_markets_cubit.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/widgets/market/market_phone_widget.dart';
import 'package:martizoom/presentation_layer/widgets/search/search_phone_widget.dart';
import 'package:martizoom/shared/components/default_app_bar/default_phone_app_bar.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';

class TopMarketsPhoneScreen extends StatefulWidget {
  TopMarketsPhoneScreen({Key? key}) : super(key: key);

  @override
  State<TopMarketsPhoneScreen> createState() => _TopMarketsPhoneScreenState();
}

class _TopMarketsPhoneScreenState extends State<TopMarketsPhoneScreen> {
  late final TopMarketsCubit _topMarketsCubit;

  @override
  void initState() {
    // TODO: implement initState
    _topMarketsCubit = TopMarketsCubit();
    _topMarketsCubit.getFirstTopMarkets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topMarkets = _topMarketsCubit.pageTopMarkets;
    return WillPopScope(
      onWillPop: () async {
        MainPagePhoneCubit.get(context).changeHomePageLevel(0);
        return false;
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) => _topMarketsCubit,
          child: BlocConsumer<TopMarketsCubit, TopMarketsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return BuildCondition(
                  condition: state is GetTopMarketsDataErrorState,
                  builder: (_) => DefaultErrorWidget(
                        error: (state as GetTopMarketsDataErrorState).error,
                      ),
                  fallback: (context) {
                    return BuildCondition(
                      condition: state is GetTopMarketsDataLoadingState,
                      builder: (_) => Center(child: LoadingScreen()),
                      fallback: (context) {
                        return BuildCondition(
                          condition: state is GetTopMarketsDataEmptyState,
                          builder: (_) => DefaultEmptyItemsText(
                            itemsName: appLocalization!.topMarkets,
                          ),
                          fallback: (context) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  SearchPhoneWidget(
                                    onPressed: () {
                                      MainPagePhoneCubit.get(context)
                                          .changeHomePageLevel(3);
                                    },
                                  ),
                                   Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      appLocalization!.topMarkets,
                                      style: const TextStyle(
                                        color: Color(0xFFce0900),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  GridView.builder(
                                    padding: const EdgeInsets.all(15.0),
                                    shrinkWrap: true,
                                    primary: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: topMarkets.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 1.0,
                                      childAspectRatio: 1.7 / 2,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return MarketPhoneWidget(
                                        topMarketModel: topMarkets[index],
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DefaultButton(
                                          disable:
                                              isPreviousButtonDisabled(state),
                                          function: () {
                                            _topMarketsCubit
                                                .getPreviousTopMarkets();
                                          },
                                          text: appLocalization!.previous,
                                          width: setWidthValue(
                                            portraitValue: 0.25,
                                            landscapeValue: 0.25,
                                          ),
                                          height: 40.0,
                                          backgroundColor:
                                              isPreviousButtonDisabled(state)
                                                  ? Colors.grey
                                                  : const Color(0xFFce0900),
                                          radius: 3.0,
                                        ),
                                        SizedBox(
                                          width: setWidthValue(
                                            portraitValue: 0.1,
                                            landscapeValue: 0.1,
                                          ),
                                        ),
                                        DefaultButton(
                                          disable: isNextButtonDisabled(state),
                                          function: () {
                                            _topMarketsCubit
                                                .getNextTopMarkets();
                                          },
                                          text: appLocalization!.next,
                                          width: setWidthValue(
                                            portraitValue: 0.25,
                                            landscapeValue: 0.25,
                                          ),
                                          height: 40.0,
                                          backgroundColor:
                                              isNextButtonDisabled(state)
                                                  ? Colors.grey
                                                  : const Color(0xFFce0900),
                                          radius: 3.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  isNextButtonDisabled(TopMarketsState state) {
    return state is GetTopMarketsDataErrorState ||
        state is GetTopMarketsDataLoadingState ||
        state is GetTopMarketsDataOnlyOnePageState ||
        state is GetTopMarketsDataLastPageState ||
        state is GetTopMarketsDataEmptyState;
  }

  isPreviousButtonDisabled(TopMarketsState state) {
    return state is GetTopMarketsDataErrorState ||
        state is GetTopMarketsDataLoadingState ||
        state is GetTopMarketsDataOnlyOnePageState ||
        state is GetTopMarketsDataFirstPageState ||
        state is GetTopMarketsDataEmptyState;
  }
}
