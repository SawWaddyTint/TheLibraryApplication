import 'package:TheLibraryApplication/resources/colors.dart';
import 'package:flutter/material.dart';

class TabNameView extends StatelessWidget {
  final String tabName;

  TabNameView(this.tabName);

  @override
  Widget build(BuildContext context) {
    return Text(
      tabName,
      style: TextStyle(
        fontSize: 15.0,
        // color: APP_THEME_COLOR,
      ),
    );
  }
}
