import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/main_page_tablet_cubit/main_page_tablet_cubit.dart';
import 'package:martizoom/business_logic_layer/search_markets_cubit/search_markets_cubit.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/widgets/market/market_tablet_widget.dart';
import 'package:martizoom/presentation_layer/widgets/search/search_tablet_widget.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/styles/colors.dart';

class SearchTabletScreen extends StatefulWidget {
  SearchTabletScreen({Key? key}) : super(key: key);

  @override
  State<SearchTabletScreen> createState() => _SearchTabletScreenState();
}

class _SearchTabletScreenState extends State<SearchTabletScreen> {
  late final SearchMarketsCubit _searchMarketsCubit;
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  String lastInputWord = ' ';

  @override
  void initState() {
    // TODO: implement initState
    _searchMarketsCubit = SearchMarketsCubit();
    // _searchMarketsCubit.getFirstMarkets(word: ' ');
    super.initState();
  }

  late var _isLandscape;

  @override
  Widget build(BuildContext context) {
    _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final topMarkets = _searchMarketsCubit.pageMarkets;
    return WillPopScope(
      onWillPop: () async {
        MainPageTabletCubit.get(context).changeHomePageLevel(0);
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchTabletWidget(
                controller: _searchTextEditingController,
                onPressed: () {},
                onSubmitted: (String value) {
                  if (value != lastInputWord) {
                    lastInputWord = value;
                    if (value.isNotEmpty) {
                      _searchMarketsCubit.getFirstMarkets(word: value);
                    } else {
                      _searchMarketsCubit.emit(SearchMarketsInitial());
                    }
                  }
                },
                readOnly: false,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  appLocalization!.searchMarkets,
                  style: const TextStyle(
                    color: Color(0xFFce0900),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => _searchMarketsCubit,
                child: BlocConsumer<SearchMarketsCubit, SearchMarketsState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return BuildCondition(
                        condition: state is SearchMarketsInitial,
                        builder: (_) => Center(
                              child: Text(
                                appLocalization!.pleaseEnterAWord,
                                style: const TextStyle(
                                    color: defaultColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                        fallback: (context) {
                          return BuildCondition(
                              condition: state is SearchMarketsDataErrorState,
                              builder: (_) => DefaultErrorWidget(
                                    error:
                                        (state as SearchMarketsDataErrorState)
                                            .error,
                                  ),
                              fallback: (context) {
                                return BuildCondition(
                                  condition:
                                      state is SearchMarketsDataLoadingState,
                                  builder: (_) =>
                                      Center(child: LoadingScreen()),
                                  fallback: (context) {
                                    return BuildCondition(
                                      condition:
                                          state is SearchMarketsDataEmptyState,
                                      builder: (_) => DefaultEmptyItemsText(
                                        itemsName:
                                            appLocalization!.searchMarkets,
                                      ),
                                      fallback: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            GridView.builder(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              shrinkWrap: true,
                                              primary: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: topMarkets.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    _isLandscape ? 5 : 4,
                                                crossAxisSpacing: 5.0,
                                                mainAxisSpacing: 1.0,
                                                childAspectRatio: _isLandscape
                                                    ? 1.65 / 2
                                                    : 1.77 / 2,
                                              ),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return MarketTabletWidget(
                                                  topMarketModel:
                                                      topMarkets[index],
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  DefaultButton(
                                                    disable:
                                                        isPreviousButtonDisabled(
                                                            state),
                                                    function: () {
                                                      _searchMarketsCubit
                                                          .getPreviousTopMarkets();
                                                    },
                                                    text: appLocalization!
                                                        .previous,
                                                    width: setWidthValue(
                                                      portraitValue: 0.25,
                                                      landscapeValue: 0.25,
                                                    ),
                                                    height: 50.0,
                                                    backgroundColor:
                                                        isPreviousButtonDisabled(
                                                                state)
                                                            ? Colors.grey
                                                            : const Color(
                                                                0xFFce0900),
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
                                                        isNextButtonDisabled(
                                                            state),
                                                    function: () {
                                                      _searchMarketsCubit
                                                          .getNextMarkets(
                                                        word:
                                                            _searchTextEditingController
                                                                .text,
                                                      );
                                                    },
                                                    text: appLocalization!.next,
                                                    width: setWidthValue(
                                                      portraitValue: 0.25,
                                                      landscapeValue: 0.25,
                                                    ),
                                                    height: 50.0,
                                                    backgroundColor:
                                                        isNextButtonDisabled(
                                                                state)
                                                            ? Colors.grey
                                                            : const Color(
                                                                0xFFce0900),
                                                    radius: 3.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              });
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  isNextButtonDisabled(SearchMarketsState state) {
    return state is SearchMarketsDataErrorState ||
        state is SearchMarketsDataLoadingState ||
        state is SearchMarketsDataOnlyOnePageState ||
        state is SearchMarketsDataLastPageState ||
        state is SearchMarketsDataEmptyState;
  }

  isPreviousButtonDisabled(SearchMarketsState state) {
    return state is SearchMarketsDataErrorState ||
        state is SearchMarketsDataLoadingState ||
        state is SearchMarketsDataOnlyOnePageState ||
        state is SearchMarketsDataFirstPageState ||
        state is SearchMarketsDataEmptyState;
  }
}
