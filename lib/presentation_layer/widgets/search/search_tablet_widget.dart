import 'package:flutter/material.dart';
import 'package:martizoom/presentation_layer/widgets/app_header/app_header_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';

class SearchTabletWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function? onSubmitted;
  final Function onPressed;
  final bool readOnly;
  String word = '';

  SearchTabletWidget({
    Key? key,
    required this.onPressed,
    this.readOnly = true,
    this.controller,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: setHeightValue(
        portraitValue: 0.23,
        landscapeValue: 0.23,
      ),
      width: double.infinity,
      child: Stack(
        children: [
          AppHeaderWidget(
            height: setHeightValue(
              portraitValue: 0.2,
              landscapeValue: 0.2,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Theme(
                    child: Expanded(
                      child: TextField(
                        autofocus: true,
                        readOnly: readOnly,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5.0),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(10.0),
                              bottomStart: Radius.circular(10.0),
                            ).resolve(languageCode == 'en'
                                ? TextDirection.ltr
                                : TextDirection.rtl),
                          ),
                          alignLabelWithHint: true,
                          hintText: appLocalization!.search,
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                        ),
                        onTap: () {
                          onPressed();
                        },
                        onChanged: (value) {
                          word = value;
                        },
                        onSubmitted: (value) {
                          onSubmitted!(value);
                        },
                      ),
                    ),
                    data: Theme.of(context).copyWith(
                      colorScheme: ThemeData().colorScheme.copyWith(
                            primary: const Color(0xFFce0900),
                          ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(10.0),
                        bottomEnd: Radius.circular(10.0),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        onSubmitted!(word);
                      },
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
