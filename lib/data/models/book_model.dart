import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/books_by_list_name_vo.dart';
import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';

abstract class BookModel {
  //Network
  Future<List<BookListVO>?>? getBookOverviewList();
  Future<List<BookVO>?>? getBooksByListName(String listName);
  Future<List<SearchBookVO>?>? getSearchBooksList(String searchText);

// Database
  Stream<List<BookListVO>?>? getBookOverviewListFromDatabase();
  Stream<List<BookVO>?>? getBooksByListNameFromDatabase(String listName);
  void saveReadBooks(BookVO book);
  void saveShelf(ShelfVO? shelf);
  void deleteShelf(ShelfVO? shelf);

  Stream<List<BookVO>> getReadBooksFromDatabase();
  Stream<List<ShelfVO>> getShelfListFromDatabase();

  //for test

  List<BookVO> testSaveReadBooks();
  List<ShelfVO> testSaveAndDeleteShelf();
}
