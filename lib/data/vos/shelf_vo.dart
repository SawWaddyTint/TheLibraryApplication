import 'package:TheLibraryApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';

import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'shelf_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_SHELF_VO, adapterName: "ShelfVOAdapter")
class ShelfVO {
  @HiveField(0)
  String id;

  @HiveField(1)
  String? shelfName;

  @HiveField(2)
  List<BookVO>? bookList;

  bool isChecked;

  ShelfVO(this.id, this.shelfName, this.bookList, {this.isChecked = false});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShelfVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          shelfName == other.shelfName;

  @override
  int get hashCode => id.hashCode ^ shelfName.hashCode;
}
