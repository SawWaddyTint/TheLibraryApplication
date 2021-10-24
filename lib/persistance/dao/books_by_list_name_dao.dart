import 'package:TheLibraryApplication/data/vos/book_vo.dart';

abstract class BooksByListNameDao {
  void saveAllBooksByListName(List<BookVO> bookList);
  List<BookVO> getAllBooksByListName();
  Stream<void> getAllBooksByListNameEventStream();
  Stream<List<BookVO>> getAllBooksByListNameStream();
  List<BookVO> getBooksByListName();
}
