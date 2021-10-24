import 'package:TheLibraryApplication/data/models/book_model.dart';
import 'package:TheLibraryApplication/data/models/book_model_impl.dart';
import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/books_by_list_name_vo.dart';
import 'package:flutter/foundation.dart';

class HomePageBlocWithProvider extends ChangeNotifier {
  // ChangeNotifier must be imported from flutter foundation

  // States
  List<BookListVO>? bookLists;
  List<BookVO>? readBookList;
  bool isDisposed = false;
  /// Models
  BookModel bookModel = BookModelImpl();

  HomePageBlocWithProvider([BookModel? testBookModel]) {
    if (testBookModel != null) {
      bookModel = testBookModel;
    }
    bookModel.getBookOverviewListFromDatabase()?.listen((bList) {
      bookLists = bList;
      if(!isDisposed){
        notifyListeners();
      }
    }).onError((error) {
      debugPrint(error.toString());
    });
    bookModel.getReadBooksFromDatabase().listen((bList) {
      readBookList = bList;

      if(!isDisposed){
        notifyListeners();
      }
    }).onError((error) {
      debugPrint(error.toString());
    });
  }

  void saveToReadBooks(BookVO? book) {
    if (book != null) {
      bookModel.saveReadBooks(book);
    }
  }

  List<BookVO> saveToReadBookTest() {
    return bookModel.testSaveReadBooks();
  }
  @override
  void dispose(){
    super.dispose();
    isDisposed = true;
  }
}
