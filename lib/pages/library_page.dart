import 'package:TheLibraryApplication/pages/search_books_page.dart';
import 'package:TheLibraryApplication/resources/colors.dart';
import 'package:TheLibraryApplication/resources/dimens.dart';

import 'package:TheLibraryApplication/view_items/searchbar_view.dart';
import 'package:TheLibraryApplication/view_items/tab_name_view.dart';
import 'package:TheLibraryApplication/pages/your_books_page.dart';
import 'package:TheLibraryApplication/pages/your_shelves_page.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> tabNameList = ["Your books", "Your shelves"];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // elevation: 0,
          toolbarHeight: Toolbar_height,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: APP_THEME_COLOR,
            unselectedLabelColor: LABEL_COLOR,
            labelColor: APP_THEME_COLOR,
            indicatorSize: TabBarIndicatorSize.label,
            onTap: (index) {
              // Tab index when user select it, it start from zero
            },
            tabs: tabNameList
                .map(
                  (tName) => Tab(
                    child: TabNameView(tName),
                  ),
                )
                .toList(),
          ),
          title: SearchBarView(0.0, () {
            _navigateToSearchBooksPage(context);
          }),
        ),
        body: TabBarView(
          children: [
            YourBooksPage(),
            YourShelvesPage(),
          ],
        ),
      ),
    );
  }

  _navigateToSearchBooksPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchBooksPage(),
      ),
    );
  }
}
