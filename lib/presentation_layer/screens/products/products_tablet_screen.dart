import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/subcategories_cubit/subcategories_cubit.dart';
import 'package:martizoom/data_layer/models/product_model.dart';
import 'package:martizoom/data_layer/models/subcategory_model.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/widgets/product/product_tablet_widget.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';

import '../../../business_logic_layer/products_cubit/products_cubit.dart';

class ProductsTabletScreen extends StatefulWidget {
  final String standId;
  final String marketId;
  final String categoryId;

  const ProductsTabletScreen({
    Key? key,
    required this.categoryId,
    required this.standId,
    required this.marketId,
  }) : super(key: key);

  @override
  State<ProductsTabletScreen> createState() => _ProductsTabletScreenState();
}

class _ProductsTabletScreenState extends State<ProductsTabletScreen> {
  String get categoryId => widget.categoryId;

  String get standId => widget.standId;

  String get marketId => widget.marketId;

  final SubcategoriesCubit _subcategoriesCubit = SubcategoriesCubit();
  final ProductsCubit _productsCubit = ProductsCubit();

  @override
  void initState() {
    _subcategoriesCubit.getSubcategories(
      standId: standId,
    );
    _productsCubit.marketId = marketId;
    _productsCubit.standId = standId;
    _productsCubit.categoryId = categoryId;
    _productsCubit.getProductsByCategory();
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
    return Scaffold(
      body: SingleChildScrollView(
        controller: _productsCubit.scrollController,
        child: Column(
          children: [
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => _productsCubit,
                ),
                BlocProvider(
                  create: (context) => _subcategoriesCubit,
                )
              ],
              child: BlocConsumer<SubcategoriesCubit, SubcategoriesState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, subcategoriesState) {
                  return BuildCondition(
                      condition:
                          subcategoriesState is GetSubcategoriesDataErrorState,
                      builder: (_) => DefaultErrorWidget(
                            error: (subcategoriesState
                                    as GetSubcategoriesDataErrorState)
                                .error,
                          ),
                      fallback: (context) {
                        return BuildCondition(
                            condition: subcategoriesState
                                is GetSubcategoriesDataLoadingState,
                            builder: (_) => LoadingScreen(),
                            fallback: (context) {
                              final List<SubcategoryModel> _subcategories =
                                  _subcategoriesCubit.subcategories;
                              return Column(
                                children: [
                                  BlocConsumer<ProductsCubit, ProductsState>(
                                    listener: (context, state) {
                                      // TODO: implement listener
                                    },
                                    builder: (context, state) {
                                      return BuildCondition(
                                          condition: state
                                              is GetProductsDataErrorState,
                                          builder: (_) => DefaultErrorWidget(
                                              error: (state
                                                      as GetProductsDataErrorState)
                                                  .error),
                                          fallback: (context) {
                                            return BuildCondition(
                                                condition: state
                                                    is GetProductsDataEmptyState,
                                                builder: (_) =>
                                                    DefaultEmptyItemsText(
                                                      itemsName:
                                                          appLocalization!
                                                              .products,
                                                    ),
                                                fallback: (context) {
                                                  return BuildCondition(
                                                      condition: state
                                                              is GetProductsDataLoadingState &&
                                                          _productsCubit.page ==
                                                              0,
                                                      builder: (_) =>
                                                          LoadingScreen(),
                                                      fallback: (context) {
                                                        final List<ProductModel>
                                                            products =
                                                            _productsCubit
                                                                .products;
                                                        return Column(
                                                          children: [
                                                            GridView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal:
                                                                    setWidthValue(
                                                                  portraitValue:
                                                                      0.03,
                                                                  landscapeValue:
                                                                      0.03,
                                                                ),
                                                                vertical:
                                                                    setHeightValue(
                                                                  portraitValue:
                                                                      0.03,
                                                                  landscapeValue:
                                                                      0.05,
                                                                ),
                                                              ),
                                                              itemCount:
                                                                  products
                                                                      .length,
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              gridDelegate:
                                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    _isLandscape
                                                                        ? 4
                                                                        : 3,
                                                                crossAxisSpacing:
                                                                    setWidthValue(
                                                                  portraitValue:
                                                                      0.03,
                                                                  landscapeValue:
                                                                      0.03,
                                                                ),
                                                                mainAxisSpacing:
                                                                    setHeightValue(
                                                                  portraitValue:
                                                                      0.02,
                                                                  landscapeValue:
                                                                      0.04,
                                                                ),
                                                                childAspectRatio:
                                                                    _isLandscape
                                                                        ? 1.33 /
                                                                            2
                                                                        : 1.11 /
                                                                            2,
                                                              ),
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return ProductTabletWidget(
                                                                  productModel:
                                                                      products[
                                                                          index],
                                                                  marketId:
                                                                      marketId,
                                                                );
                                                              },
                                                            ),
                                                            if (state
                                                                    is GetProductsDataLoadingState &&
                                                                _productsCubit
                                                                        .page !=
                                                                    0)
                                                              const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                          ],
                                                        );
                                                      });
                                                });
                                          });
                                    },
                                  ),
                                ],
                              );
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
