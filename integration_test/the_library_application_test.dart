import 'package:TheLibraryApplication/data/vos/book_details_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_overview_result.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/books_by_list_name_vo.dart';
import 'package:TheLibraryApplication/data/vos/buy_links_vo.dart';
import 'package:TheLibraryApplication/data/vos/isbns_vo.dart';
import 'package:TheLibraryApplication/data/vos/reviews_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/main.dart';
import 'package:TheLibraryApplication/pages/create_shelf.dart';

import 'package:TheLibraryApplication/pages/home_page.dart';
import 'package:TheLibraryApplication/pages/shelf_details_page.dart';
import 'package:TheLibraryApplication/pages/tabs_page.dart';
import 'package:TheLibraryApplication/persistance/hive_constants.dart';
import 'package:TheLibraryApplication/view_items/searchbar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';

import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

  testWidgets("Use Case 1 - Add eBook to Library + Change View",
      (WidgetTester tester) async {
    // tap to certain book
    await tester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.byType(HomePage), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.byKey(Key(BookKey)), findsOneWidget);

    await tester.tap(find.byKey(Key(BookKey)));
    await tester.pumpAndSettle(Duration(seconds: 3));

    // verify book data in Book Details Page and go to Library
    expect(find.text(TEST_DATA_BOOK_TITLE), findsOneWidget);
    expect(find.text(TEST_DATA_AUTHOR), findsOneWidget);
    expect(find.text(TEST_DATA_PUBLISHER), findsOneWidget);
    expect(find.text(TEST_DATA_BOOK_DESCRIPTION), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios));
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.byIcon(Icons.library_books_outlined));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text(TEST_DATA_BOOK_TITLE), findsOneWidget);

    // tap Large Grid and verify Large Grid View
    await tester.tap(find.byIcon(Icons.grid_on_outlined));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text("Large grid"));
    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.byKey(Key(LargeGridKey)), findsOneWidget);
    expect(find.byIcon(Icons.list_alt), findsOneWidget);

    // tap Small Grid and verify Small Grid View
    await tester.tap(find.byIcon(Icons.list_alt));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text("Small grid"));
    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.byKey(Key(SmallGridKey)), findsOneWidget);
    expect(find.byIcon(Icons.list_alt), findsOneWidget);

    await tester.tap(find.byIcon(Icons.list_alt));
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.text("List"));
    await tester.pumpAndSettle(Duration(seconds: 2));
    expect(find.byKey(Key(ListViewKey)), findsOneWidget);
    expect(find.byIcon(Icons.grid_on_outlined), findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 1));
  });

  testWidgets("Use Case 2 - Search Books", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));

    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(HomePage), findsOneWidget);

    expect(find.byType(SearchBarView), findsOneWidget);

    await tester.tap(find.byType(SearchBarView));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.enterText(find.byType(TextField), "user");
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text(TEST_DATA_SEARCH_BOOK_TITLE), findsOneWidget);
  });

  testWidgets("Use Case 3 - Create Shelf + Delete Shelf + Edit Shelf",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.byType(TabsPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.library_books_outlined));
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.text("Your shelves"));
    await tester.pumpAndSettle(Duration(seconds: 2));

    //test create new shelf
    await tester.tap(find.text("Create new"));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text("Shelf name"), findsOneWidget);

    await tester.enterText(find.byType(TextField), "Test Shelf");
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.byType(CreateShelfButton));
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.byIcon(Icons.arrow_back_ios));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text("Test Shelf"), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 1));

    // test rename shelf
    await tester.tap(find.text("Test Shelf"));
    await tester.pumpAndSettle(Duration(seconds: 2));
    expect(find.text("Test Shelf"), findsOneWidget);
    expect(find.text("0 book"), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.byIcon(Icons.more_horiz));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text("Rename shelf"));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text("Test Shelf"), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.enterText(find.byType(TextField), "Test Shelf edited");
    await tester.pumpAndSettle(Duration(seconds: 1));

    await tester.tap(find.byType(CreateShelfButtonInShelfDetails));

    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(find.text("Test Shelf edited"), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.arrow_back_ios));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text("Test Shelf edited"), findsOneWidget);

// test delete shelf
    await tester.tap(find.text("Test Shelf edited"));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text("Test Shelf edited"), findsOneWidget);
    expect(find.text("0 book"), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.byIcon(Icons.more_horiz));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text("Delete Shelf"));
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.text("Delete"));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text("Test Shelf edited"), findsNothing);

    await tester.pumpAndSettle(Duration(seconds: 2));
  });

  testWidgets("Use Case 4 - Add Book To Shelf ", (WidgetTester tester) async {
// tap to certain book
    await tester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.byKey(Key(BookKey)));
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.byIcon(Icons.arrow_back_ios));
    await tester.pumpAndSettle(Duration(seconds: 3));

    // navigate to add to shelves page
    expect(find.byKey(Key(CarouselBookKey)), findsOneWidget);

    await tester.tap(find.byKey(Key(CarouselBookKey)));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text("Add to shelves..."));
    await tester.pumpAndSettle(Duration(seconds: 1));

    // create new shelf to add book
    await tester.tap(find.text("Create new"));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.enterText(find.byType(TextField), "Test Add Book");
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.byType(CreateShelfButton));
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.byIcon(Icons.arrow_back_ios));
    await tester.pumpAndSettle(Duration(seconds: 1));

    // add book to shelf
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text("DONE"));
    await tester.pumpAndSettle(Duration(seconds: 2));

    // verify added book in related shelf
    await tester.tap(find.byIcon(Icons.library_books_outlined));
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.text("Your shelves"));
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.text("Test Add Book"));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text(TEST_DATA_BOOK_TITLE), findsOneWidget);
  });
}
