import 'package:flutter/material.dart';
import 'package:martizoom/data_layer/models/category_model.dart';
import 'package:martizoom/presentation_layer/screens/category/category_tablet_screen.dart';
import 'package:martizoom/shared/constants/constants.dart';

class CategoryTabletWidget extends StatelessWidget {
  final String marketId;
  final CategoryModel categoryModel;

  const CategoryTabletWidget(
      {Key? key, required this.categoryModel, required this.marketId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
          context: context,
          screen: CategoryTabletScreen(
            categoryId: (categoryModel.id ?? '0').toString(),
            marketId: marketId,
            sceneId: '1',
            categoryName: categoryModel.name ?? '',
          ),
        );
      },
      child: Column(
        children: [
          Column(
            children: [
              Container(
                height: setHeightValue(
                  portraitValue: 0.13,
                  landscapeValue: 0.28,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                  color: Colors.grey,
                ),
                child: Image.network(
                  categoryModel.image ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: setHeightValue(
                      portraitValue: 0.13,
                      landscapeValue: 0.28,
                    ),
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              categoryModel.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
