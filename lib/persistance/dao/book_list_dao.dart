import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';

abstract class BookListDao {
  void saveAllBooks(List<BookListVO> bookList);
  List<BookListVO> getAllBookList();
  Stream<void> getAllBookListEventStream();
  Stream<List<BookListVO>> getAllBookListStream();
  List<BookListVO> getBookLists();
}
