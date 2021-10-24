import 'package:TheLibraryApplication/data/models/book_model.dart';
import 'package:TheLibraryApplication/data/models/book_model_impl.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/foundation.dart';

class ShelfBlocWithProvider extends ChangeNotifier {
  // ChangeNotifier must be imported from flutter foundation

  // States

  List<ShelfVO>? shelfList;
  bool hasValue = false;
  bool showCreatedShelf = false;
  var uuid = Uuid();
  bool isDisposed = false;

  /// Models
  BookModel bookModel = BookModelImpl();
  int charLength = 0;
  bool hasSameName = false;
  ShelfBlocWithProvider({String? listName, BookModel? testBookModel}) {
    if (testBookModel != null) {
      bookModel = testBookModel;
    }
    bookModel.getShelfListFromDatabase().listen((list) {
      shelfList = list;
if(!isDisposed){
  notifyListeners();
}



    }).onError((error) {
      debugPrint(error.toString());
    });

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

  saveShelf(ShelfVO shelf) {
    shelf.id = uuid.v1();

    this.saveShelfToDatabase(shelf);
    showCreatedShelf = true;
    hasValue = false;
    notifyListeners();
  }

  // void checkShelfName(BuildContext context, ShelfVO shelf) {
  //   if (shelfList.length > 0) {
  //     for (int i = 0; i < shelfList.length; i++) {
  //       if (shelfList[i].shelfName.contains(shelf.shelfName)) {
  //         hasSameName = true;
  //         // _showAlertDiaLog(context);
  //       } else
  //         hasSameName = false;
  //       _saveShelf(shelf);
  //     }
  //   } else
  //     _saveShelf(shelf);
  // }

  void checkShelfName(BuildContext context, ShelfVO shelf) {
    saveShelf(shelf);
  }

  void saveShelfToDatabase(ShelfVO shelf) {
    bookModel.saveShelf(shelf);
  }

  List<ShelfVO> saveShelfToDatabaseTest() {
    return bookModel.testSaveAndDeleteShelf();
  }

  @override
  void dispose(){
    super.dispose();
    isDisposed = true;
  }
}
