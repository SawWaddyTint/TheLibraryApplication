import 'package:TheLibraryApplication/pages/home_page.dart';
import 'package:TheLibraryApplication/pages/library_page.dart';
import 'package:TheLibraryApplication/resources/colors.dart';

import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

final List<Widget> _children = [
  HomePage(),
  LibraryPage(),
  //  PlaceholderWidget(Colors.green)
];

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _children[_currentIndex], // new
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: APP_THEME_COLOR,
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // new
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,key: Key("Home"),),
              label: 'Home',
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.library_books_outlined,key: Key("Library")),
              label: 'Library',
            ),
          ],
        ),
      ),
    );
  }
}
