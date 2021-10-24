import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/persistance/dao/read_books_list_dao.dart';

import '../mock_data/mock_data.dart';

class ReadBooksListDaoImplMock extends ReadBooksListDao {
  Map<String, BookVO> readBooksListInDatabaseMock = {};
  @override
  @override
  Stream<List<BookVO>> getAllBookListStream() {
    return Stream.value(getMockBooksByListName());
  }

  @override
  Stream<void> getAllReadBookListEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<BookVO> getAllReadBookLists() {
    return getMockBooksByListName();
  }

  @override
  List<BookVO> getReadBooksList() {
    return readBooksListInDatabaseMock.values.toList();
  }

  @override
  void saveReadBooks(BookVO book) {
    readBooksListInDatabaseMock[book.primaryIsbn10] = book;
  }

  @override
  void deleteBookFromLibrary(BookVO book) {
    readBooksListInDatabaseMock.remove(book.primaryIsbn10);
  }
}
