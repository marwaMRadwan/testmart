import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
        top: 10.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );
  }
}
