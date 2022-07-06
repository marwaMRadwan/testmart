import 'package:flutter/material.dart';
import 'package:martizoom/shared/constants/constants.dart';

class MySliderPhoneWidget extends StatelessWidget {
  final String? image, title;

  //Constructor created
  MySliderPhoneWidget({Key? key, this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: setWidthValue(
              portraitValue: 0.1,
              landscapeValue: 0.1,
            ),
          ),
          child: Text(
            title!,
            style: TextStyle(
              fontSize: setWidthValue(
                portraitValue: 0.06,
                landscapeValue: 0.03,
              ),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: setHeightValue(
            portraitValue: 0.03,
            landscapeValue: 0.05,
          ),
        ),
        Image(
          image: AssetImage(
            image!,
          ),
          width: double.infinity,
          height: setHeightValue(
            portraitValue: 0.4,
            landscapeValue: 0.7,
          ),
        ),
      ],
    );
  }
}
