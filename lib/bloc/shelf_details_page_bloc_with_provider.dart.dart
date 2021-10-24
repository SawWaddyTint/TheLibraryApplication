import 'package:TheLibraryApplication/data/models/book_model.dart';
import 'package:TheLibraryApplication/data/models/book_model_impl.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';

import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ShelfDetailsPageBlocWithProvider extends ChangeNotifier {
  // States

  int layoutIndexForBooks = 1;
  List<String> selectedType = [];
  List<String> filterType = [
    "Downloaded",
    "Not downloaded",
    "Not started",
    "In progress",
  ];
  int charLength = 0;
  int? selectedView;
  bool showDowloadAndNotDownloaded = true;
  bool showNotStartedAndShowInProgess = true;
  bool showSelectedFilter = false;
  bool showListView = true;
  bool showLargeGrid = false;
  bool showSmallGrid = false;
  int? layoutIndex;
  bool renameFlag = false;
  ShelfVO? detailsShelf;
  String sortedType = "Recent";
  bool hasValue = false;
  bool showCreatedShelf = false;
  bool flag = false;

  /// Models
  BookModel bookModel = BookModelImpl();

  ShelfDetailsPageBlocWithProvider({ShelfVO? shelf, BookModel? testBookModel}) {
    if (testBookModel != null) {
      bookModel = testBookModel;
    }
    renameFlag = false;
    detailsShelf = shelf ?? ShelfVO("", "", []);

    notifyListeners();
  }

  void changeLayoutStyle(int layoutIndex) {
    if (layoutIndex == 1) {
      layoutIndexForBooks = 1;
      notifyListeners();
    } else if (layoutIndex == 2) {
      layoutIndexForBooks = 2;
      notifyListeners();
    } else {
      layoutIndexForBooks = 3;
      notifyListeners();
    }
  }

  void getSelectedItems(String selected) {
    if (selected == "Downloaded") {
      _addItemToSelectedType(selected);

      showDowloadAndNotDownloaded = false;
      showSelectedFilter = true;
      notifyListeners();
    }

    if (selected == "Not downloaded") {
      _addItemToSelectedType(selected);

      showDowloadAndNotDownloaded = false;
      showSelectedFilter = true;
      notifyListeners();
    }

    if (selected == "Not started") {
      _addItemToSelectedType(selected);
      showNotStartedAndShowInProgess = false;
      showSelectedFilter = true;
      notifyListeners();
    }

    if (selected == "In progress") {
      _addItemToSelectedType(selected);

      showNotStartedAndShowInProgess = false;
      showSelectedFilter = true;
      notifyListeners();
    }
  }

  void _addItemToSelectedType(String type) {
    selectedType.add(type);

    notifyListeners();
  }

  void removeFilters() {
    selectedType = [];
    showSelectedFilter = false;
    showDowloadAndNotDownloaded = true;
    showNotStartedAndShowInProgess = true;
    notifyListeners();
  }

  void deleteShelf(ShelfVO? shelf) {
    bookModel.deleteShelf(shelf);
  }

  void clickRename() {
    renameFlag = true;
    notifyListeners();
  }

  onChanged(String value) {
    charLength = value.length;

    if (charLength > 0) {
      hasValue = true;
      notifyListeners();
    } else {
      hasValue = false;
      notifyListeners();
    }
  }

  void checkShelfNameForShelfDetails(BuildContext context, ShelfVO? shelf) {
    updateShelf(shelf);
  }

  updateShelf(ShelfVO? shelf) {
    bookModel.saveShelf(shelf);
    showCreatedShelf = true;
    hasValue = false;
    renameFlag = false;
    _getUpdatedShelf();
    notifyListeners();
  }

  _getUpdatedShelf() {
    bookModel.getShelfListFromDatabase().listen((shelfList) {
      for (int i = 0; i < shelfList.length; i++) {
        if (shelfList[i].id == detailsShelf?.id) {
          detailsShelf = shelfList[i];
          notifyListeners();
        } else
          debugPrint("There is no shelf !!!");
      }
    });
  }

  void sortedBySelectedIndex(int value) {
    if (value == 1) {
      detailsShelf?.bookList?.sort((a, b) {
        return (a.createdDate?.compareTo(b.createdDate ?? "") ?? 0);
      });
      sortedType = "Recent";
      notifyListeners();
    }
    if (value == 2) {
      detailsShelf?.bookList?.sort((a, b) {
        return a.title?.compareTo(b.title ?? "") ?? 0;
      });
      sortedType = "Title";
      notifyListeners();
    } else if (value == 3) {
      detailsShelf?.bookList?.sort((a, b) {
        return a.author?.compareTo(b.author ?? "") ?? 0;
      });
      sortedType = "Author";
      notifyListeners();
    }
  }

  removeFromCurrentShelf(BookVO? book) {
    for (int i = 0; i < (detailsShelf?.bookList?.length ?? 0); i++) {
      if (detailsShelf?.bookList?[i].primaryIsbn10 == book?.primaryIsbn10) {
        detailsShelf?.bookList?.removeAt(i);
        bookModel.saveShelf(detailsShelf ?? ShelfVO("", "", []));
        notifyListeners();
      } else
        debugPrint("no need to delete");
    }
  }

  deleteFromLibrary(BookVO book) {
    bookModel.getShelfListFromDatabase().listen((shelfs) {
      for (int i = 0; i < shelfs.length; i++) {
        for (int j = 0; j < (shelfs[i].bookList?.length ?? 0); i++) {
          if (shelfs[i].bookList?[j].primaryIsbn10 == book.primaryIsbn10) {
            shelfs[i].bookList?.removeAt(i);
            bookModel.saveShelf(shelfs[i]);
          } else
            bookModel.saveShelf(shelfs[i]);
        }
      }
      flag = true;
    });

    if (flag) {
      bookModel.getShelfListFromDatabase().listen((shelfs) {
        for (int i = 0; i < shelfs.length; i++) {
          if (shelfs[i].id == detailsShelf?.id) {
            detailsShelf = shelfs[i];
            notifyListeners();
          }
        }
      });
    }
  }

  List<ShelfVO> saveAndDeleteShelfToDatabaseTest() {
    return bookModel.testSaveAndDeleteShelf();
  }
}
