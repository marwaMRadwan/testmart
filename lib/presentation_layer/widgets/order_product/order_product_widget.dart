import 'package:flutter/material.dart';
import 'package:martizoom/data_layer/models/single_order_model.dart';
import 'package:martizoom/shared/constants/constants.dart';

class OrderProductWidget extends StatefulWidget {
  final OrderProductModel productModel;

  OrderProductWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<OrderProductWidget> createState() => _OrderProductWidgetState();
}

class _OrderProductWidgetState extends State<OrderProductWidget> {
  OrderProductModel get productModel => widget.productModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: Image.network(
            //productModel.image ?? '',
            '',
            fit: BoxFit.fill,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productModel.productsName ?? '',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                productModel.productsName ?? '',
                style: const TextStyle(
                  color: Color(0XFF8D98A4),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${productModel.productsPrice ?? '0'}  x ${productModel.productsQuantity}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
