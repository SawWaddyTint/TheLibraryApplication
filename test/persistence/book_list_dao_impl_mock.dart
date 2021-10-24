import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/persistance/dao/book_list_dao.dart';

import '../mock_data/mock_data.dart';

class BookListDaoImplMock extends BookListDao {
  Map<int, BookListVO> bookListInDatabaseMock = {};
  @override
  List<BookListVO> getAllBookList() {
    return getMockBookOverviewList();
  }

  @override
  Stream<void> getAllBookListEventStream() {
    return Stream<void>.value(null);
  }

  @override
  Stream<List<BookListVO>> getAllBookListStream() {
    return Stream.value(getMockBookOverviewList());
  }

  @override
  List<BookListVO> getBookLists() {
    return getMockBookOverviewList();
  }

  @override
  void saveAllBooks(List<BookListVO> bookList) {
    bookList.forEach((books) {
      bookListInDatabaseMock[books.listId] = books;
    });
  }
}
