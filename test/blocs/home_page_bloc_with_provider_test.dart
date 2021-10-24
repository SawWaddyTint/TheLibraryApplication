import 'package:TheLibraryApplication/bloc/home_page_bloc_with_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Home page bloc with provider test", () {
    HomePageBlocWithProvider? bloc;
    setUp(() {
      bloc = HomePageBlocWithProvider(BookModelImplMock());
    });

    test("Fetch book overview list from database test", () {
      expect(
        bloc?.bookLists?.contains(getMockBookOverviewList().first),
        true,
      );
    });

    test("Fetch read books from database test", () {
      expect(
        bloc?.readBookList?.contains(getMockBooksByListName().first),
        true,
      );
    });

    test("save read book  test", () {
      bloc?.saveToReadBooks(getMockBooksByListName()[0]);
      expect(
        bloc?.saveToReadBookTest().contains(getMockBooksByListName().first),
        true,
      );
    });
  });
}
