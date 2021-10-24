import 'package:TheLibraryApplication/data/vos/book_vo.dart';

abstract class ReadBooksListDao {
  void saveReadBooks(BookVO book);
  List<BookVO> getReadBooksList();
  void deleteBookFromLibrary(BookVO book);
  Stream<void> getAllReadBookListEventStream();
  Stream<List<BookVO>> getAllBookListStream();
  List<BookVO> getAllReadBookLists();
}
