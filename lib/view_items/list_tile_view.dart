import 'package:TheLibraryApplication/resources/colors.dart';
import 'package:flutter/material.dart';

class ListTileView extends StatelessWidget {
  final String _text;
  final Icon _icon;
  ListTileView(this._text, this._icon);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // dense: true,
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      leading: _icon,
      title: Text(
        _text,
        style: TextStyle(
          color: LABEL_COLOR,
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
