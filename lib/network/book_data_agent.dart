import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/books_by_list_name_vo.dart';
import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';

abstract class BookDataAgent {
  Future<List<BookListVO>?>? getBookOverviewList();
  Future<List<BookVO>?>? getBooksByListName(String listName);
  Future<List<SearchBookVO>?>? getSearchBooksList(String searchText);
}
