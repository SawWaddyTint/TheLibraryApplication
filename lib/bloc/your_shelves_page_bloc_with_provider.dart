import 'package:TheLibraryApplication/data/models/book_model.dart';
import 'package:TheLibraryApplication/data/models/book_model_impl.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/foundation.dart';

class YourShelvesPageBlocWithProvider extends ChangeNotifier {
  // ChangeNotifier must be imported from flutter foundation

  // States
  List<ShelfVO>? allCreatedShelves = [];
  bool showList = false;
  bool isDisposed = false;
  /// Models
  BookModel bookModel = BookModelImpl();

  YourShelvesPageBlocWithProvider([BookModel? testBookModel]) {
    if (testBookModel != null) {
      bookModel = testBookModel;
    }
    bookModel.getShelfListFromDatabase().listen((list) {
      allCreatedShelves = list;
      if ((allCreatedShelves?.length ?? 0) > 0) {
        showList = true;
        if(!isDisposed){
          notifyListeners();
        }
      } else
        showList = false;
      if(!isDisposed){
        notifyListeners();
      }
    }).onError((error) {
      debugPrint(error.toString());
    });
  }
  @override
  void dispose(){
    super.dispose();
    isDisposed = true;
  }
}
