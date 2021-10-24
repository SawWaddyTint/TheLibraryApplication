import 'package:TheLibraryApplication/bloc/your_books_page_bloc_with_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Your books page bloc with provider test", () {
    YourBooksPageBlocWithProvider? bloc;
    setUp(() {
      bloc = YourBooksPageBlocWithProvider(testBookModel: BookModelImplMock());
    });
    test("get read books from database test", () {
      expect(
        bloc?.readBooks?.contains(getMockBooksByListName().first),
        true,
      );
    });

    test("change list view test", () {
      bloc?.changeLayoutStyle(1);
      expect(
        bloc?.layoutIndexForBooks,
        1,
      );
    });
    test("change Large Grid view test", () {
      bloc?.changeLayoutStyle(2);
      expect(
        bloc?.layoutIndexForBooks,
        2,
      );
    });
    test("change Small Grid view test", () {
      bloc?.changeLayoutStyle(3);
      expect(
        bloc?.layoutIndexForBooks,
        3,
      );
    });
    test("sorting by Recent test", () async {
      bloc?.sortedBySelectedIndex(1);
      await Future.delayed(Duration(milliseconds: 500));
      expect(
        bloc?.readBooks,
        getMockReadBooks(),
      );
    });


    test("sorting by Title test", () async {
      bloc?.sortedBySelectedIndex(2);
      await Future.delayed(Duration(milliseconds: 500));
      expect(
        bloc?.readBooks,
        [getMockReadBooks()[1],getMockReadBooks()[0]],
      );
    });

    test("sorting by Author test", () async {
      bloc?.sortedBySelectedIndex(3);
      await Future.delayed(Duration(milliseconds: 500));
      expect(
        bloc?.readBooks,
     getMockReadBooks(),
      );
    });
  });
}
