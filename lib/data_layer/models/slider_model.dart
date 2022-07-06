import 'package:flutter/cupertino.dart';

import '../../shared/constants/constants.dart';

class SliderModel {
  String? image;
  String? title;

// Constructor for variables
  SliderModel({this.title, this.image});

  void setImage(String getImage) {
    image = getImage;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  String? getImage() {
    return image;
  }

  String? getTitle() {
    return title;
  }
}

// List created
List<SliderModel> getSlides() {

  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = SliderModel();

// Item 1
  sliderModel.setImage("assets/images/2.jpg");
  sliderModel.setTitle(appLocalization!.youCanOrderAntTimeFromOnlineMarket);
  slides.add(sliderModel);

  sliderModel = SliderModel();

// Item 2
  sliderModel.setImage("assets/images/3.jpg");
  sliderModel.setTitle(appLocalization!.youCanPayQuicklyWithQrCode);
  slides.add(sliderModel);

  sliderModel = SliderModel();

// Item 3
  sliderModel.setImage("assets/images/4.jpg");
  sliderModel.setTitle(appLocalization!.trackYourDeliveryInRealTime);
  slides.add(sliderModel);

  sliderModel = SliderModel();

  return slides;
}
