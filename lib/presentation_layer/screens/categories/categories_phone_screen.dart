import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/categories_cubit/categories_cubit.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/widgets/app_header/app_header_widget.dart';
import 'package:martizoom/presentation_layer/widgets/category/category_phone_widget.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';

class CategoriesPhoneScreen extends StatefulWidget {
  final String marketId;
  final String marketName;

  CategoriesPhoneScreen(
      {Key? key, required this.marketId, required this.marketName})
      : super(key: key);

  @override
  State<CategoriesPhoneScreen> createState() => _CategoriesPhoneScreenState();
}

class _CategoriesPhoneScreenState extends State<CategoriesPhoneScreen> {
  String get marketId => widget.marketId;

  String get marketName => widget.marketName;

  late final CategoriesCubit _categoriesCubit;

  @override
  void initState() {
    // TODO: implement initState
    _categoriesCubit = CategoriesCubit();
    _categoriesCubit.getCategories(marketId: marketId);
    super.initState();
  }

  var _screenWidth;

  var _screenHeight;

  var _isLandscape;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final categories = _categoriesCubit.categories;
    return Scaffold(
      body: BlocProvider(
        create: (context) => _categoriesCubit,
        child: BlocConsumer<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
              children: [
                AppHeaderWidget(
                  height: setHeightValue(
                    portraitValue: 0.2,
                    landscapeValue: 0.3,
                  ),
                  title: marketName,
                ),
                Expanded(
                  child: BuildCondition(
                      condition: state is GetCategoriesDataErrorState,
                      builder: (_) => DefaultErrorWidget(
                            error: (state as GetCategoriesDataErrorState).error,
                          ),
                      fallback: (context) {
                        return BuildCondition(
                          condition: state is GetCategoriesDataLoadingState,
                          builder: (_) => LoadingScreen(),
                          fallback: (context) {
                            return BuildCondition(
                              condition: state is GetCategoriesDataEmptyState,
                              builder: (_) => DefaultEmptyItemsText(
                                itemsName: appLocalization!.categories,
                              ),
                              fallback: (context) {
                                return GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: setWidthValue(
                                      portraitValue: 0.03,
                                      landscapeValue: 0.05,
                                    ),
                                    vertical: setHeightValue(
                                      portraitValue: 0.03,
                                      landscapeValue: 0.05,
                                    ),
                                  ),
                                  itemCount: categories.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: _isLandscape ? 4 : 3,
                                    crossAxisSpacing: setWidthValue(
                                      portraitValue: 0.02,
                                      landscapeValue: 0.02,
                                    ),
                                    mainAxisSpacing: setHeightValue(
                                      portraitValue: 0.01,
                                      landscapeValue: 0.01,
                                    ),
                                    childAspectRatio:
                                        _isLandscape ? 1.9 / 2 : 1.7 / 2,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CategoryPhoneWidget(
                                      categoryModel: categories[index],
                                      marketId: marketId,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
