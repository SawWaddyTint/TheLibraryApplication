import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/persistance/dao/read_books_list_dao.dart';

import 'package:TheLibraryApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';

class ReadBooksListDaoImpl extends ReadBooksListDao {
  static final ReadBooksListDaoImpl _singleton =
      ReadBooksListDaoImpl._internal();

  factory ReadBooksListDaoImpl() {
    return _singleton;
  }
  ReadBooksListDaoImpl._internal();

  // void saveReadBooks(List<BooksByListNameVO> bookList) async {
  //   Map<int, BooksByListNameVO> bookListMap = Map.fromIterable(bookList,
  //       key: (list) => list.listId, value: (list) => list);
  //   await getBookListBox().putAll(bookListMap);
  // }
  List<BookVO> bookList = [];
  void saveReadBooks(BookVO book) async {
    bookList = getReadBooksList();
    bookList.add(book);
    Map<String, BookVO> bookListMap = Map.fromIterable(bookList,
        key: (list) => list.primaryIsbn10, value: (list) => list);
    await getBookListBox().putAll(bookListMap);
  }

  List<BookVO> getReadBooksList() {
    return getBookListBox().values.toList();
  }

  Box<BookVO> getBookListBox() {
    return Hive.box<BookVO>(BOX_NAME_READ_BOOKS_LIST_VO);
  }

  void deleteBookFromLibrary(BookVO book) async {
    await getBookListBox().delete(book.primaryIsbn10);
  }

  /// reactive programming
  Stream<void> getAllReadBookListEventStream() {
    return getBookListBox().watch();
  }

  Stream<List<BookVO>> getAllBookListStream() {
    return Stream.value(getReadBooksList().toList());
  }

  List<BookVO> getAllReadBookLists() {
    return getReadBooksList().toList();
  }
}
