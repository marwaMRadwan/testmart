import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/main_page_tablet_cubit/main_page_tablet_cubit.dart';
import 'package:martizoom/business_logic_layer/markets_cubit/markets_cubit.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/widgets/market/market_tablet_widget.dart';
import 'package:martizoom/presentation_layer/widgets/search/search_tablet_widget.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import '../../../shared/constants/constants.dart';

class MarketsTabletScreen extends StatefulWidget {
  const MarketsTabletScreen({Key? key}) : super(key: key);

  @override
  State<MarketsTabletScreen> createState() => _MarketsTabletScreenState();
}

class _MarketsTabletScreenState extends State<MarketsTabletScreen> {
  late final MarketsCubit _marketsCubit;

  @override
  void initState() {
    // TODO: implement initState
    _marketsCubit = MarketsCubit();
    _marketsCubit.getFirstMarkets();
    super.initState();
  }

  late var _isLandscape;

  @override
  Widget build(BuildContext context) {
    _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final markets = _marketsCubit.pageMarkets;
    return WillPopScope(
      onWillPop: () async {
        MainPageTabletCubit.get(context).changeHomePageLevel(0);
        return false;
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) => _marketsCubit,
          child: BlocConsumer<MarketsCubit, MarketsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return BuildCondition(
                  condition: state is GetMarketsDataErrorState,
                  builder: (_) => DefaultErrorWidget(
                        error: (state as GetMarketsDataErrorState).error,
                      ),
                  fallback: (context) {
                    return BuildCondition(
                      condition: state is GetMarketsDataLoadingState,
                      builder: (_) => LoadingScreen(),
                      fallback: (context) {
                        return BuildCondition(
                            condition: state is GetMarketsDataEmptyState,
                            builder: (_) => DefaultEmptyItemsText(
                                  itemsName: appLocalization!.markets,
                                ),
                            fallback: (context) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SearchTabletWidget(
                                      onPressed: () {
                                        MainPageTabletCubit.get(context)
                                            .changeHomePageLevel(3);
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        appLocalization!.markets,
                                        style: const TextStyle(
                                          color: Color(0xFFce0900),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    GridView.builder(
                                      padding: const EdgeInsets.all(15.0),
                                      itemCount: markets.length,
                                      shrinkWrap: true,
                                      primary: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: _isLandscape ? 5 : 4,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 1.0,
                                        childAspectRatio:
                                            _isLandscape ?1.77/ 2 : 1.77 / 2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return MarketTabletWidget(
                                          topMarketModel: markets[index],
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
                                              _marketsCubit
                                                  .getPreviousMarkets();
                                            },
                                            text: appLocalization!.previous,
                                            width: setWidthValue(
                                              portraitValue: 0.25,
                                              landscapeValue: 0.25,
                                            ),
                                            height: 50.0,
                                            backgroundColor:
                                                isPreviousButtonDisabled(state)
                                                    ? Colors.grey
                                                    : const Color(0xFFce0900),
                                            radius: 3.0,
                                          ),
                                          SizedBox(
                                            width: setWidthValue(
                                              portraitValue: 0.08,
                                              landscapeValue: 0.08,
                                            ),
                                          ),
                                          DefaultButton(
                                            disable:
                                                isNextButtonDisabled(state),
                                            function: () {
                                              _marketsCubit.getNextMarkets();
                                            },
                                            text: appLocalization!.next,
                                            width: setWidthValue(
                                              portraitValue: 0.25,
                                              landscapeValue: 0.25,
                                            ),
                                            height: 50.0,
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
                            });
                      },
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  isNextButtonDisabled(MarketsState state) {
    return state is GetMarketsDataErrorState ||
        state is GetMarketsDataLoadingState ||
        state is GetMarketsDataOnlyOnePageState ||
        state is GetMarketsDataLastPageState ||
        state is GetMarketsDataEmptyState;
  }

  isPreviousButtonDisabled(MarketsState state) {
    return state is GetMarketsDataErrorState ||
        state is GetMarketsDataLoadingState ||
        state is GetMarketsDataOnlyOnePageState ||
        state is GetMarketsDataFirstPageState ||
        state is GetMarketsDataEmptyState;
  }
}
