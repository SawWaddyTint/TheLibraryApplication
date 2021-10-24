import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/persistance/dao/books_by_list_name_dao.dart';

import '../mock_data/mock_data.dart';

class BooksByListNameDaoImplMock extends BooksByListNameDao {
  Map<int, BookVO> booksByListNameInDatabaseMock = {};
  @override
  List<BookVO> getAllBooksByListName() {
    return getMockBooksByListName();
  }

  @override
  Stream<void> getAllBooksByListNameEventStream() {
    return Stream<void>.value(null);
  }

  @override
  Stream<List<BookVO>> getAllBooksByListNameStream() {
    return Stream.value(getMockBooksByListName());
  }

  @override
  List<BookVO> getBooksByListName() {
    return getMockBooksByListName();
  }

  @override
  void saveAllBooksByListName(List<BookVO> bookList) {
    bookList.forEach((books) {
      booksByListNameInDatabaseMock[books.rank ?? 0] = books;
    });
  }
}
