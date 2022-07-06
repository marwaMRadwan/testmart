import 'package:flutter/material.dart';
import 'package:martizoom/presentation_layer/screens/main_page/main_page_tablet_screen.dart';
import 'package:martizoom/presentation_layer/widgets/my_slider/my_slider_tablet_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/network/local/cache_helper.dart';

import '../../../data_layer/models/slider_model.dart';

class OnBoardTabletScreen extends StatefulWidget {
  final bool showViewDialog;

  const OnBoardTabletScreen({Key? key, required this.showViewDialog})
      : super(key: key);

  @override
  _OnBoardTabletScreenState createState() => _OnBoardTabletScreenState();
}

class _OnBoardTabletScreenState extends State<OnBoardTabletScreen> {
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
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: setHeightValue(
                  portraitValue: 0.02,
                  landscapeValue: 0.02,
                ),
              ),
              SizedBox(
                height: setHeightValue(
                  portraitValue: 0.73,
                  landscapeValue: 1.0,
                ),
                child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      return MySliderTabletWidget(
                        image: slides[index].getImage(),
                        title: slides[index].getTitle(),
                      );
                    }),
              ),
              const SizedBox(
                height: 5.0,
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
                      portraitValue: 0.06,
                      landscapeValue: 0.1,
                    ),
                    width: setWidthValue(
                      portraitValue: 0.3,
                      landscapeValue: 0.2,
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
                        style: TextStyle(
                          fontSize: setWidthValue(
                            portraitValue: 0.03,
                            landscapeValue: 0.02,
                          ),
                        ),
                      ),
                      onPressed: () {
                        CacheHelper.saveData(
                          key: 'isBoard',
                          value: false,
                        );
                        navigateAndFinishTo(
                          context: context,
                          screen: MainPageTabletScreen(
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
              const SizedBox(
                height: 10.0,
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
        portraitValue: 0.011,
        landscapeValue: 0.02,
      ),
      width: currentIndex == index
          ? setWidthValue(
              portraitValue: 0.11,
              landscapeValue: 0.085,
            )
          : setWidthValue(
              portraitValue: 0.031,
              landscapeValue: 0.025,
            ),
      margin: const EdgeInsets.only(
        right: 5.0,
        bottom: 5.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: const Color(0xFFE04428),
      ),
    );
  }
}
