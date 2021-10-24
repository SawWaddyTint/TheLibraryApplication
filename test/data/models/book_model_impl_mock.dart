import 'package:TheLibraryApplication/data/models/book_model.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/persistance/dao/read_books_list_dao.dart';
import 'package:TheLibraryApplication/persistance/dao/shelf_dao.dart';

import '../../mock_data/mock_data.dart';
import '../../persistence/read_books_list_dao_impl_mock.dart';
import '../../persistence/shelf_dao_impl_mock.dart';

class BookModelImplMock extends BookModel {
  ReadBooksListDao readBooksListDao = ReadBooksListDaoImplMock();
  ShelfDao shelfDao = ShelfDaoImplMock();
  @override
  void deleteShelf(ShelfVO? shelf) {
    shelfDao.deleteShelf(shelf);
  }

  @override
  Future<List<BookListVO>?>? getBookOverviewList() {
    return Future.value(getMockBookOverviewList());
  }

  @override
  Stream<List<BookListVO>?>? getBookOverviewListFromDatabase() {
    return Stream.value(getMockBookOverviewList());
  }

  @override
  Future<List<BookVO>?>? getBooksByListName(String listName) {
    return Future.value(getMockBooksByListName());
  }

  @override
  Stream<List<BookVO>?>? getBooksByListNameFromDatabase(String listName) {
    return Stream.value(getMockBooksByListName());
  }

  @override
  Stream<List<BookVO>> getReadBooksFromDatabase() {
    return Stream.value(getMockReadBooks());
  }

  @override
  Future<List<SearchBookVO>?>? getSearchBooksList(String searchText) {
    return Future.value(getMockSearchBooksList());
  }

  @override
  Stream<List<ShelfVO>> getShelfListFromDatabase() {
    return Stream.value(getMockShelves());
  }

  @override
  void saveReadBooks(BookVO book) {
    readBooksListDao.saveReadBooks(book);
  }

  @override
  void saveShelf(ShelfVO? shelf) {
    shelfDao.saveShelf(shelf);
  }

  @override
  List<ShelfVO> testSaveAndDeleteShelf() {
    return shelfDao.getShelfList();
  }

  @override
  List<BookVO> testSaveReadBooks() {
    return readBooksListDao.getReadBooksList();
  }
}
