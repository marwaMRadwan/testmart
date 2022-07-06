import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/stands_cubit/stands_cubit.dart';
import 'package:martizoom/data_layer/models/stand_model.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/screens/products/products_phone_screen.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';

import '../../../widgets/app_header/app_header_widget.dart';

class StandsPhoneView extends StatefulWidget {
  String marketId;
  String categoryId;
  String categoryName;

  StandsPhoneView({
    Key? key,
    required this.marketId,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<StandsPhoneView> createState() => _StandsPhoneViewState();
}

class _StandsPhoneViewState extends State<StandsPhoneView> {
  String get marketId => widget.marketId;

  String get categoryId => widget.categoryId;

  String get categoryName => widget.categoryName;

  final StandsCubit _standsCubit = StandsCubit();

  @override
  void initState() {
    _standsCubit.getStands(
      marketId: marketId,
      categoryId: categoryId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: DefaultAppBar(
      //   title: categoryName,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeaderWidget(
              height: setHeightValue(
                portraitValue: 0.2,
                landscapeValue: 0.3,
              ),
              title: categoryName,
            ),
            BlocProvider(
              create: (context) => _standsCubit,
              child: BlocConsumer<StandsCubit, StandsState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return BuildCondition(
                      condition: state is GetStandsDataErrorState,
                      builder: (_) => DefaultErrorWidget(
                            error: (state as GetStandsDataErrorState).error,
                          ),
                      fallback: (context) {
                        return BuildCondition(
                            condition: state is GetStandsDataEmptyState,
                            builder: (_) => DefaultEmptyItemsText(
                                  itemsName: appLocalization!.items,
                                ),
                            fallback: (context) {
                              return BuildCondition(
                                  condition: state is GetStandsDataLoadingState,
                                  builder: (_) => LoadingScreen(),
                                  fallback: (context) {
                                    final List<StandModel> stands =
                                        _standsCubit.stands;
                                    return DefaultTabController(
                                      length: stands.length,
                                      child: SizedBox(
                                        height: setHeightValue(
                                          portraitValue: 0.8,
                                          landscapeValue: 0.7,
                                        ),
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              alignment: Alignment.center,
                                              child: TabBar(
                                                isScrollable: true,
                                                tabs: stands
                                                    .map(
                                                      (stand) => Tab(
                                                        child: Text(
                                                            '${stand.title}'),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                            Expanded(
                                              child: TabBarView(
                                                  children: stands
                                                      .map(
                                                        (stand) =>
                                                            ProductsPhoneScreen(
                                                          categoryId:
                                                              categoryId,
                                                          marketId: marketId,
                                                          standId:
                                                              stand.id ?? '0',
                                                        ),
                                                      )
                                                      .toList()),
                                            )
                                          ],
                                        ),
                                      ),
                                    );

                                  });
                            });
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
