import 'package:TheLibraryApplication/data/models/book_model.dart';
import 'package:TheLibraryApplication/data/models/book_model_impl.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';

import 'package:TheLibraryApplication/data/vos/books_by_list_name_vo.dart';
import 'package:flutter/foundation.dart';

class YourBooksPageBlocWithProvider extends ChangeNotifier {
  // States
  List<BookVO>? readBooks;
  int layoutIndexForBooks = 1;
  String sortedType = "Recent";
  int? selectedView;
  bool showDowloadAndNotDownloaded = true;
  bool showNotStartedAndShowInProgess = true;
  bool showSelectedFilter = false;
  bool showListView = true;
  bool showLargeGrid = false;
  bool showSmallGrid = false;
  int? layoutIndex;
  List<String>? selectedType = [];
  List<String> filterType = [
    "Downloaded",
    "Not downloaded",
    "Not started",
    "In progress",
  ];
  bool isDisposed = false;
  /// Models
  BookModel bookModel = BookModelImpl();

  YourBooksPageBlocWithProvider({String? listName, BookModel? testBookModel}) {
    if (testBookModel != null) {
      bookModel = testBookModel;
    }
    bookModel.getReadBooksFromDatabase().listen((bList) {
      readBooks = bList;
      layoutIndexForBooks = 1;
      if(!isDisposed){
        notifyListeners();
      }
    }).onError((error) {
      debugPrint(error.toString());
    });
  }

  void  changeLayoutStyle(int layoutIndex) {
    if (layoutIndex == 1) {
      layoutIndexForBooks = 1;
      if(!isDisposed){
        notifyListeners();
      }
    } else if (layoutIndex == 2) {
      layoutIndexForBooks = 2;
      if(!isDisposed){
        notifyListeners();
      }
    } else {
      layoutIndexForBooks = 3;
      if(!isDisposed){
        notifyListeners();
      }
    }
  }

  void getSelectedItems(String selected) {
    if (selected == "Downloaded") {
      _addItemToSelectedType(selected);

      showDowloadAndNotDownloaded = false;
      showSelectedFilter = true;
      if(!isDisposed){
        notifyListeners();
      }
    }

    if (selected == "Not downloaded") {
      _addItemToSelectedType(selected);

      showDowloadAndNotDownloaded = false;
      showSelectedFilter = true;
      if(!isDisposed){
        notifyListeners();
      }
    }

    if (selected == "Not started") {
      _addItemToSelectedType(selected);
      showNotStartedAndShowInProgess = false;
      showSelectedFilter = true;
      if(!isDisposed){
        notifyListeners();
      }
    }

    if (selected == "In progress") {
      _addItemToSelectedType(selected);

      showNotStartedAndShowInProgess = false;
      showSelectedFilter = true;
      if(!isDisposed){
        notifyListeners();
      }
    }
  }

  void _addItemToSelectedType(String type) {
    selectedType?.add(type);
    if(!isDisposed){
      notifyListeners();
    }
  }

  void removeFilters() {
    selectedType = [];
    showSelectedFilter = false;
    showDowloadAndNotDownloaded = true;
    showNotStartedAndShowInProgess = true;
    if(!isDisposed){
      notifyListeners();
    }
  }

  void sortedBySelectedIndex(int value) {
    if (value == 1) {
      readBooks?.sort((a, b) {
        return (a.createdDate?.compareTo(b.createdDate ?? "")) ?? 0;
      });
      sortedType = "Recent";
      if(!isDisposed){
        notifyListeners();
      }
    }
    if (value == 2) {
      readBooks?.sort((a, b) {
        return a.title?.compareTo(b.title ?? "") ?? 0;
      });
      sortedType = "Title";
      if(!isDisposed){
        notifyListeners();
      }
    } else if (value == 3) {
      readBooks?.sort((a, b) {
        return a.author?.compareTo(b.author ?? "") ?? 0;
      });
      sortedType = "Author";
      if(!isDisposed){
        notifyListeners();
      }
    }
  }
  @override
  void dispose(){
    super.dispose();
    isDisposed = true;
  }
}
