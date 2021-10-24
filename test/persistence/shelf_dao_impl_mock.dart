import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/persistance/dao/shelf_dao.dart';

import '../mock_data/mock_data.dart';

class ShelfDaoImplMock extends ShelfDao {
  Map<String, ShelfVO> shelfInDatabaseMock = {};
  @override
  void deleteShelf(ShelfVO? shelf) {
    if (shelf != null) {
      shelfInDatabaseMock.remove(shelf.id);
    }
  }

  @override
  List<ShelfVO> getAllShelfList() {
    return getMockShelves();
  }

  @override
  Stream<void> getShelfListEventStream() {
    return Stream<void>.value(null);
  }

  @override
  Stream<List<ShelfVO>> getShelfListStream() {
    return Stream.value(getMockShelves());
  }

  @override
  void saveShelf(ShelfVO? shelf) {
    if (shelf != null) {
      shelfInDatabaseMock[shelf.id] = shelf;
    }
  }

  @override
  List<ShelfVO> getShelfList() {
    return shelfInDatabaseMock.values.toList();
  }
}
