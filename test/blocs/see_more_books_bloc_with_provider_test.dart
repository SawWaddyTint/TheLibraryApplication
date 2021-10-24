import 'package:TheLibraryApplication/bloc/see_more_books_bloc_with_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("See more books bloc with provider test", () {
    SeeMoreBooksBlocWithProvider? bloc;
    setUp(() {
      bloc = SeeMoreBooksBlocWithProvider(testBookModel: BookModelImplMock());
    });
    test("Fetch books by list name from database test", () {
      expect(
        bloc?.readBooks?.contains(getMockBooksByListName().first),
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
