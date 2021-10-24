import 'package:TheLibraryApplication/bloc/shelf_details_page_bloc_with_provider.dart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Shelf details page bloc with provider test", () {
    ShelfDetailsPageBlocWithProvider? bloc;
    setUp(() {
      bloc = ShelfDetailsPageBlocWithProvider(
          shelf: getMockShelves()[0], testBookModel: BookModelImplMock());
    });

    test("Fetch shelves from database test", () {
      expect(
        bloc?.detailsShelf,
        getMockShelves()[0],
      );
    });
    test("save shelf to database test", () {
      bloc?.updateShelf(getMockShelves()[0]);
      expect(
        bloc
            ?.saveAndDeleteShelfToDatabaseTest()
            .contains(getMockShelves().first),
        true,
      );
    });

    test("delete shelf from database test", () {
      bloc?.deleteShelf(getMockShelves()[0]);
      expect(
        bloc?.saveAndDeleteShelfToDatabaseTest(),
        [],
      );
    });
  });
}
