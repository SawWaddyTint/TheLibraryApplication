import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';

abstract class ShelfDao {
  void saveShelf(ShelfVO? shelf);
  void deleteShelf(ShelfVO? shelf);
  List<ShelfVO> getShelfList();
  Stream<void> getShelfListEventStream();
  Stream<List<ShelfVO>> getShelfListStream();
  List<ShelfVO> getAllShelfList();
}
