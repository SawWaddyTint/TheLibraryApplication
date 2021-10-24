import 'package:TheLibraryApplication/data/vos/book_details_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_overview_result.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/books_by_list_name_vo.dart';
import 'package:TheLibraryApplication/data/vos/buy_links_vo.dart';
import 'package:TheLibraryApplication/data/vos/isbns_vo.dart';
import 'package:TheLibraryApplication/data/vos/reviews_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/persistance/hive_constants.dart';

import 'package:TheLibraryApplication/pages/tabs_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/vos/book_list_vo.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(BookListVOAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(BookOverviewResultVOAdapter());
  Hive.registerAdapter(BuyLinksVOAdapter());
  Hive.registerAdapter(BooksByListNameVOAdapter());
  Hive.registerAdapter(IsbnsVOAdapter());
  Hive.registerAdapter(BookDetailsVOAdapter());
  Hive.registerAdapter(ReviewsVOAdapter());
  Hive.registerAdapter(ShelfVOAdapter());

  await Hive.openBox<BookListVO>(BOX_NAME_BOOK_LIST_VO);
  await Hive.openBox<BooksByListNameVO>(BOX_NAME_BOOKS_BY_LIST_NAME_VO);
  await Hive.openBox<BookVO>(BOX_NAME_BOOKS_BY_LIST_NAME_VO1);
  await Hive.openBox<BookVO>(BOX_NAME_READ_BOOKS_LIST_VO);
  await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_LIST_VO);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabsPage(),
    );
  }
}
