import 'package:TheLibraryApplication/data/models/book_model.dart';
import 'package:TheLibraryApplication/data/models/book_model_impl.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';
import 'package:flutter/foundation.dart';

class SearchBooksPageBlocWithProvider extends ChangeNotifier {
  // States
  bool hasValue = false;
  bool showCreatedShelf = false;
  int charLength = 0;
  List<SearchBookVO>? searchBooksList;
  bool showSearchedList = false;
  bool showSubmittedList = false;
  bool noData = false;

  /// Models
  BookModel bookModel = BookModelImpl();

  SearchBooksPageBlocWithProvider([BookModel? testBookModel]) {
    if (testBookModel != null) {
      bookModel = testBookModel;
    }
  }

  void onChanged(String value) {
    charLength = value.length;

    if (charLength > 0) {
      hasValue = true;
      showSubmittedList = false;
      notifyListeners();
      _getSearchedBooks(value);
    } else {
      hasValue = false;
      showSearchedList = false;
      showSubmittedList = false;
      searchBooksList = [];
      notifyListeners();
    }
  }

  void onSubmitted(String value) {
    charLength = value.length;

    if (charLength > 0) {
      hasValue = true;
      showSearchedList = false;
      showSubmittedList = true;
      notifyListeners();
      getSubmittedSearchedBooks(value);
    } else {
      hasValue = false;
      showSearchedList = false;
      showSubmittedList = false;
      searchBooksList = [];
      notifyListeners();
    }
  }

  void getSubmittedSearchedBooks(String value) {
    showSubmittedList = true;
    bookModel.getSearchBooksList(value)?.then((bList) {
      searchBooksList = bList;
      if (searchBooksList?.length == 0) {
        noData = true;
      } else {
        noData = false;
      }

      showSubmittedList = true;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void _getSearchedBooks(String value) {
    showSearchedList = true;
    bookModel.getSearchBooksList(value)?.then((bList) {
      searchBooksList = bList;
      if (searchBooksList?.length == 0) {
        noData = true;
      } else {
        noData = false;
      }
      showSearchedList = true;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void saveToReadBooks(SearchBookVO? sbBook) {
    // SearchBookVO? sb;
    // BookVO book = BookVO(
    //     "",
    //     "",
    //     "",
    //     (sbBook?.volumeInfo?.authors != null)
    //         ? (sbBook?.volumeInfo?.authors?[0] ?? "")
    //         : "",
    //     sbBook?.volumeInfo?.imageLinks?.thumbnail ??
    //         "https://p.kindpng.com/picc/s/84-843028_book-clipart-square-blank-book-cover-clip-art.png",
    //     0,
    //     0,
    //     "",
    //     "",
    //     "",
    //     "",
    //     sbBook?.volumeInfo?.description ?? "",
    //     "",
    //     "",
    //     sbBook?.volumeInfo?.industryIdentifiers?[0].identifier ?? "",
    //     "",
    //     "bookUri",
    //     sbBook?.volumeInfo?.publisher,
    //     0,
    //     0,
    //     "",
    //     sbBook?.volumeInfo?.title ?? "",
    //     "",
    //     0,
    //     [],
    //     0,
    //     []);
    // bookModel.saveReadBooks(book);
    // sb.convertToBookVO(sbBook);
    if (sbBook != null) {
      BookVO book = sbBook.convert(sbBook);
      bookModel.saveReadBooks(book);
    }
  }

  List<BookVO> saveToReadBookTest() {
    return bookModel.testSaveReadBooks();
  }
}
