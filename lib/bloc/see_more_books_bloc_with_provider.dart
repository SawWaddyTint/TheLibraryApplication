import 'package:TheLibraryApplication/data/models/book_model.dart';
import 'package:TheLibraryApplication/data/models/book_model_impl.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:flutter/foundation.dart';

class SeeMoreBooksBlocWithProvider extends ChangeNotifier {
  // States
  List<BookVO>? readBooks;

  /// Models
  BookModel bookModel = BookModelImpl();

  SeeMoreBooksBlocWithProvider({String? listName, BookModel? testBookModel}) {
    if (testBookModel != null) {
      bookModel = testBookModel;
    }
    bookModel.getBooksByListNameFromDatabase(listName ?? "")?.listen((bList) {
      readBooks = bList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });
  }

  void saveToReadBooks(BookVO book) {
    bookModel.saveReadBooks(book);
  }

  List<BookVO> saveToReadBookTest() {
    return bookModel.testSaveReadBooks();
  }
}
