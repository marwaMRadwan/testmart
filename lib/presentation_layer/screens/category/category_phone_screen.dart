import 'package:flutter/material.dart';
import 'package:martizoom/presentation_layer/screens/category/2d/stands_phone_view.dart';
import 'package:martizoom/shared/constants/constants.dart';

import '3d/unity_page.dart';

class CategoryPhoneScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  final String marketId;
  final String sceneId;

  const CategoryPhoneScreen({
    Key? key,
    required this.categoryId,
    required this.marketId,
    required this.sceneId,
    required this.categoryName,
  }) : super(key: key);

  @override
  _CategoryPhoneScreenState createState() => _CategoryPhoneScreenState();
}

class _CategoryPhoneScreenState extends State<CategoryPhoneScreen> {
  String get categoryId => widget.categoryId;

  String get marketId => widget.marketId;

  String get sceneId => widget.sceneId;

  String get categoryName => widget.categoryName;

  @override
  Widget build(BuildContext context) {
    return viewType == '2d'
        ? StandsPhoneView(
            marketId: marketId,
            categoryId: categoryId,
            categoryName: categoryName,
          )
        :


     StandsPhoneView(
         marketId: marketId,
         categoryId: categoryId,
         categoryName: categoryName,
       );
  }
}
