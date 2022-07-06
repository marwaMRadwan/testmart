import 'package:flutter/material.dart';

import '../../../shared/constants/constants.dart';

class LoadingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const CircularProgressIndicator(
            color: Color(0xFFce0900),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              appLocalization!.loading,
              style: const TextStyle(
                color: Color(0xFFce0900),
                fontSize: 18.0,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
