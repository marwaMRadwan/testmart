import 'package:flutter/material.dart';
import 'package:martizoom/presentation_layer/screens/main_page/main_page_phone_screen.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/network/local/cache_helper.dart';

import '../../../data_layer/models/slider_model.dart';
import '../../widgets/my_slider/my_slider_phone_widget.dart';

class OnBoardPhoneScreen extends StatefulWidget {
  final bool showViewDialog;

  const OnBoardPhoneScreen({Key? key, required this.showViewDialog})
      : super(key: key);

  @override
  _OnBoardPhoneScreenState createState() => _OnBoardPhoneScreenState();
}

class _OnBoardPhoneScreenState extends State<OnBoardPhoneScreen> {
  List<SliderModel> slides = <SliderModel>[];
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = PageController(initialPage: 0);
    slides = getSlides();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: setHeightValue(
                  portraitValue: 0.03,
                  landscapeValue: 0.03,
                ),
              ),
              SizedBox(
                height: setHeightValue(
                  portraitValue: 0.75,
                  landscapeValue: 1.0,
                ),
                width: double.infinity,
                child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      return MySliderPhoneWidget(
                        image: slides[index].getImage(),
                        title: slides[index].getTitle(),
                      );
                    }),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  slides.length,
                  (index) => buildDot(index, context),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: setHeightValue(
                      portraitValue: 0.07,
                      landscapeValue: 0.12,
                    ),
                    width: setWidthValue(
                      portraitValue: 0.35,
                      landscapeValue: 0.18,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE04428),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                    ),
                    child: FlatButton(
                      child: Text(
                        appLocalization!.getStarted,
                      ),
                      onPressed: () {
                        CacheHelper.saveData(
                          key: 'isBoard',
                          value: false,
                        );
                        navigateAndFinishTo(
                          context: context,
                          screen: MainPagePhoneScreen(
                            showViewDialog: widget.showViewDialog,
                          ),
                        );
                      },
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

// container created for dots
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: setHeightValue(
        portraitValue: 0.01,
        landscapeValue: 0.016,
      ),
      width: currentIndex == index
          ? setWidthValue(
              portraitValue: 0.1,
              landscapeValue: 0.08,
            )
          : setWidthValue(
              portraitValue: 0.03,
              landscapeValue: 0.015,
            ),
      margin: const EdgeInsetsDirectional.only(
        end: 5.0,
        bottom: 10.0,
        top: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: const Color(0xFFce0900),
      ),
    );
  }
}
