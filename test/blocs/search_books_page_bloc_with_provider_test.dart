import 'package:TheLibraryApplication/bloc/search_books_page_bloc_with_provider.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("search books page bloc with provider test", () {
    SearchBooksPageBlocWithProvider? bloc;
    setUp(() {
      bloc = SearchBooksPageBlocWithProvider(BookModelImplMock());
    });
    test("Fetch search books list from network test", () async {
      bloc?.getSubmittedSearchedBooks("");
      await Future.delayed(Duration(milliseconds: 500));
      expect(
        bloc?.searchBooksList?.contains(getMockSearchBooksList().first),
        true,
      );
    });
    test("save read book  test", () async {
      bloc?.saveToReadBooks(getMockSearchBooksList()[0]);
      await Future.delayed(Duration(milliseconds: 500));
      expect(
        bloc?.saveToReadBookTest().contains(
              BookVO(
                "",
                "",
                "",
                "Gavin Allanwood",
                "http://books.google.com/books/content?id=LTUeAwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                0,
                0,
                "",
                "",
                "",
                "",
                "By putting people at the centre of interactive design, user experience (UX) techniques are now right at the heart of digital media design and development. As a designer, you need to create work that will impact positively on everyone who is exposed to it. Whether it's passive and immutable or interactive and dynamic, the success of your design will depend largely on how well the user experience is constructed.User Experience Design shows how researching and understanding users' expectations and motivations can help you develop effective, targeted designs. The authors explore the use of scenarios, personas and prototyping in idea development, and will help you get the most out of the latest tools and techniques to produce interactive designs that users will love.With practical projects to get you started, and stunning examples from some of today's most innovative studios, this is an essential introduction to modern UXD.",
                "",
                "",
                "9782940496136",
                "",
                "bookUri",
                "A&C Black",
                0,
                0,
                "",
                "Basics Interactive Design: User Experience Design",
                "",
                0,
                [],
                0,
                [],
              ),
            ),
        true,
      );
    });
  });
}
