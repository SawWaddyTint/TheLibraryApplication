import 'package:TheLibraryApplication/data/models/book_model.dart';
import 'package:TheLibraryApplication/data/models/book_model_impl.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/foundation.dart';

class AddToShelvesPageBlocWithProvider extends ChangeNotifier {
  // ChangeNotifier must be imported from flutter foundation

  // States
  List<ShelfVO>? allCreatedShelves = [];
  var uuid = Uuid();
  bool showList = false;
  BookVO? addedBook;
  List<ShelfVO>? selectedShelves = [];
  bool hasSameBook = false;

  /// Models
  BookModel bookModel = BookModelImpl();
  int charLength = 0;
  AddToShelvesPageBlocWithProvider({BookVO? book, BookModel? testBookModel}) {
    if (testBookModel != null) {
      bookModel = testBookModel;
    }
    addedBook = book;
    bookModel.getShelfListFromDatabase().listen((list) {
      allCreatedShelves = list;
      // allCreatedShelves?.forEach((element) {

      // });
      notifyListeners();

      if ((allCreatedShelves?.length ?? 0) > 0) {
        showList = true;
        notifyListeners();
        for (int i = 0; i < (allCreatedShelves?.length ?? 0); i++) {
          for (int j = 0;
              j < (allCreatedShelves?[i].bookList?.length ?? 0);
              j++) {
            if (allCreatedShelves?[i].bookList?[j].primaryIsbn10 ==
                addedBook?.primaryIsbn10) {
              allCreatedShelves?[i].isChecked = true;
              break;
            } else
              allCreatedShelves?[i].isChecked = false;
          }
        }
      } else
        showList = false;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });
  }
  void selectShelves(ShelfVO selectedShelf) {
    selectedShelf.isChecked = !selectedShelf.isChecked;
    if (selectedShelf.isChecked == true) {
      for (int i = 0; i < (selectedShelf.bookList?.length ?? 0); i++) {
        if (selectedShelf.bookList?[i].primaryIsbn10 !=
            addedBook?.primaryIsbn10) {
          hasSameBook = false;
        } else
          hasSameBook = true;
      }
      if (!hasSameBook) {
        selectedShelf.bookList?.add(addedBook!);
        this.saveBookToShelf(selectedShelf);

        notifyListeners();
      } else
        debugPrint("There are same books !");
    } else {
      for (int i = 0; i < (selectedShelf.bookList?.length ?? 0); i++) {
        if (selectedShelf.bookList?[i].primaryIsbn10 ==
            addedBook?.primaryIsbn10) {
          selectedShelf.bookList?.removeAt(i);
          this.saveBookToShelf(selectedShelf);
          notifyListeners();
        } else
          debugPrint("no need to delete");
      }
    }
  }

  void saveBookToShelf(ShelfVO selectedShelf) {
    bookModel.saveShelf(selectedShelf);
  }

  List<ShelfVO> testSaveBookToShelf() {
    return bookModel.testSaveAndDeleteShelf();
  }
}
