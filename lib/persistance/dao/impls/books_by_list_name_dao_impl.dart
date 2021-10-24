import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/persistance/dao/books_by_list_name_dao.dart';

import 'package:TheLibraryApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';

class BooksByListNameDaoImpl extends BooksByListNameDao {
  static final BooksByListNameDaoImpl _singleton =
      BooksByListNameDaoImpl._internal();

  factory BooksByListNameDaoImpl() {
    return _singleton;
  }
  BooksByListNameDaoImpl._internal();

  void saveAllBooksByListName(List<BookVO> bookList) async {
    Map<int, BookVO> bookListMap = Map.fromIterable(bookList,
        key: (list) => list.rank, value: (list) => list);
    await getBooksByListNameBox().clear();
    await getBooksByListNameBox().putAll(bookListMap);
  }

  List<BookVO> getAllBooksByListName() {
    return getBooksByListNameBox().values.toList();
  }

  Box<BookVO> getBooksByListNameBox() {
    return Hive.box<BookVO>(BOX_NAME_BOOKS_BY_LIST_NAME_VO1);
  }

  /// reactive programming
  Stream<void> getAllBooksByListNameEventStream() {
    return getBooksByListNameBox().watch();
  }

  Stream<List<BookVO>> getAllBooksByListNameStream() {
    return Stream.value(getAllBooksByListName().toList());
  }

  List<BookVO> getBooksByListName() {
    return getAllBooksByListName().toList();
  }
}
