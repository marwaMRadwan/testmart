import 'package:flutter/material.dart';
import 'package:martizoom/shared/components/default_app_bar/default_tablet_app_bar.dart';

class AppItemInfoTabletScreen extends StatelessWidget {
  final String title;
  final String content;

  const AppItemInfoTabletScreen({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultTabletAppBar(
        title: title,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          15.0,
        ),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
