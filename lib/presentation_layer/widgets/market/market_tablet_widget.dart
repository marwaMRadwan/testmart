import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:martizoom/data_layer/models/market_model.dart';
import 'package:martizoom/presentation_layer/screens/categories/categories_tablet_screen.dart';
import 'package:martizoom/shared/constants/constants.dart';

class MarketTabletWidget extends StatelessWidget {
  final MarketModel topMarketModel;

  const MarketTabletWidget({Key? key, required this.topMarketModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (topMarketModel.isOpen == 0) {
          showErrorToast(
            error: PermissionDeniedException(
              appLocalization!.marketIsOfflineNow,
            ),
          );
        } else {
          navigateTo(
            context: context,
            screen: CategoriesTabletScreen(
              marketId: topMarketModel.id ?? '0',
              marketName: topMarketModel.name ?? '',
            ),
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: setWidthValue(
              portraitValue: 0.26,
              landscapeValue: 0.2,
            ),
            height: setHeightValue(
              portraitValue: 0.14,
              landscapeValue: 0.28,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image.network(
                    topMarketModel.image ?? '',
                    fit: BoxFit.fill,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey,
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  if (topMarketModel.isOpen == 0)
                    Container(
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          appLocalization!.closed,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
          const SizedBox(
            height: 3.0,
          ),
          Text(
            topMarketModel.name ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }
}
