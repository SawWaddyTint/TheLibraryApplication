import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/persistance/dao/book_list_dao.dart';
import 'package:TheLibraryApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';

class BookListDaoImpl extends BookListDao {
  static final BookListDaoImpl _singleton = BookListDaoImpl._internal();

  factory BookListDaoImpl() {
    return _singleton;
  }
  BookListDaoImpl._internal();

  void saveAllBooks(List<BookListVO> bookList) async {
    Map<int, BookListVO> bookListMap = Map.fromIterable(bookList,
        key: (list) => list.listId, value: (list) => list);
    await getBookListBox().putAll(bookListMap);
  }

  List<BookListVO> getAllBookList() {
    return getBookListBox().values.toList();
  }

  Box<BookListVO> getBookListBox() {
    return Hive.box<BookListVO>(BOX_NAME_BOOK_LIST_VO);
  }

  /// reactive programming
  Stream<void> getAllBookListEventStream() {
    return getBookListBox().watch();
  }

  Stream<List<BookListVO>> getAllBookListStream() {
    return Stream.value(getAllBookList().toList());
  }

  List<BookListVO> getBookLists() {
    return getAllBookList().toList();
  }
}
