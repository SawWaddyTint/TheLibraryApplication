import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/pages/your_shelves_page.dart';
import 'package:TheLibraryApplication/persistance/dao/shelf_dao.dart';
import 'package:TheLibraryApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';

class ShelfDaoImpl extends ShelfDao {
  static final ShelfDaoImpl _singleton = ShelfDaoImpl._internal();

  factory ShelfDaoImpl() {
    return _singleton;
  }
  ShelfDaoImpl._internal();

  List<ShelfVO> shelfList = [];
  List<BookVO> addedBook = [];
  void saveShelf(ShelfVO? shelf) async {
    if (shelf != null) {
      shelfList = getShelfList();
      shelfList.add(shelf);
      Map<String, ShelfVO> shelfListMap = Map.fromIterable(shelfList,
          key: (list) => list.id, value: (list) => list);
      await getShelfListBox().putAll(shelfListMap);
      // await getShelfListBox().deleteAt(index)
    }
  }

  void deleteShelf(ShelfVO? shelf) async {
    await getShelfListBox().delete(shelf?.id);
  }

  List<ShelfVO> getShelfList() {
    return getShelfListBox().values.toList();
  }

  Box<ShelfVO> getShelfListBox() {
    return Hive.box<ShelfVO>(BOX_NAME_SHELF_LIST_VO);
  }

  /// reactive programming
  Stream<void> getShelfListEventStream() {
    return getShelfListBox().watch();
  }

  Stream<List<ShelfVO>> getShelfListStream() {
    return Stream.value(getShelfList().toList());
  }

  List<ShelfVO> getAllShelfList() {
    return getShelfList().toList();
  }
}
