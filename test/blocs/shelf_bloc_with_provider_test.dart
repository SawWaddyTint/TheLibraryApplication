import 'package:TheLibraryApplication/bloc/shelf_bloc_with_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Shelf bloc with provider test", () {
    ShelfBlocWithProvider? bloc;
    setUp(() {
      bloc = ShelfBlocWithProvider(testBookModel: BookModelImplMock());
    });
    test("Fetch shelves from database test", () {
      expect(
        bloc?.shelfList?.contains(getMockShelves().first),
        true,
      );
    });

    test("save shelf to database  test", () {
      bloc?.saveShelfToDatabase(getMockShelves()[0]);
      expect(
        bloc?.saveShelfToDatabaseTest().contains(getMockShelves().first),
        true,
      );
    });
  });
}
