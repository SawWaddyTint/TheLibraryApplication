import 'package:TheLibraryApplication/bloc/add_to_shelves_page_bloc_with_provider.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/buy_links_vo.dart';
import 'package:TheLibraryApplication/data/vos/isbns_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/persistance/hive_constants.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/models/book_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Add to shelves page bloc with provider test", () {
    AddToShelvesPageBlocWithProvider? bloc;
    setUp(() {
      bloc =
          AddToShelvesPageBlocWithProvider(testBookModel: BookModelImplMock());
    });

    test("Fetch created shelves test", () {
      expect(
        bloc?.allCreatedShelves?.contains(getMockShelves().first),
        true,
      );
    });

    test("save book to shelf test", () {
      bloc?.saveBookToShelf(
        ShelfVO(
          '1',
          "Test Shelf",
          [
            BookVO(
              "",
              "https://www.amazon.com/dp/0735222355?tag=NYTBSREV-20",
              "",
              "Amor Towles",
              "https://storage.googleapis.com/du-prd/books/images/9780735222359.jpg",
              331,
              500,
              "",
              "by Amor Towles",
              "",
              "2021-10-13 22:12:26",
              "Two friends who escaped from a juvenile work farm take Emmett Watson on an unexpected journey to New York City in 1954.",
              "",
              "0.00",
              "0735222355",
              "9780735222359",
              "nyt://book/43839b1f-c8cc-5ef4-8893-bd85582906a4",
              "Viking",
              1,
              0,
              "",
              "THE LINCOLN HIGHWAY",
              "2021-10-15 20:13:01",
              1,
              [
                BuyLinksVO("Amazon",
                    "https://www.amazon.com/dp/0735222355?tag=NYTBSREV-20")
              ],
              1,
              [
                IsbnsVO(
                  "1984821520",
                  "9781984821522",
                )
              ],
            ),
          ],
          isChecked: true,
        ),
      );
      expect(
        bloc?.testSaveBookToShelf().contains(
              ShelfVO(
                '1',
                "Test Shelf",
                [
                  BookVO(
                    "",
                    "https://www.amazon.com/dp/0735222355?tag=NYTBSREV-20",
                    "",
                    "Amor Towles",
                    "https://storage.googleapis.com/du-prd/books/images/9780735222359.jpg",
                    331,
                    500,
                    "",
                    "by Amor Towles",
                    "",
                    "2021-10-13 22:12:26",
                    "Two friends who escaped from a juvenile work farm take Emmett Watson on an unexpected journey to New York City in 1954.",
                    "",
                    "0.00",
                    "0735222355",
                    "9780735222359",
                    "nyt://book/43839b1f-c8cc-5ef4-8893-bd85582906a4",
                    "Viking",
                    1,
                    0,
                    "",
                    "THE LINCOLN HIGHWAY",
                    "2021-10-15 20:13:01",
                    1,
                    [
                      BuyLinksVO("Amazon",
                          "https://www.amazon.com/dp/0735222355?tag=NYTBSREV-20")
                    ],
                    1,
                    [
                      IsbnsVO(
                        "1984821520",
                        "9781984821522",
                      )
                    ],
                  ),
                ],
                isChecked: true,
              ),
            ),
        true,
      );
    });
  });
}
