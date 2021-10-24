import 'package:TheLibraryApplication/bloc/your_shelves_page_bloc_with_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Your shelves page bloc with provider test", () {
    YourShelvesPageBlocWithProvider? bloc;
    setUp(() {
      bloc = YourShelvesPageBlocWithProvider(BookModelImplMock());
    });

    test("get all created shelves from database test", () {
      expect(
        bloc?.allCreatedShelves?.contains(getMockShelves().first),
        true,
      );
    });
  });
}
