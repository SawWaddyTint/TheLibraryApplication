import 'package:TheLibraryApplication/data/models/book_model_impl.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/buy_links_vo.dart';
import 'package:TheLibraryApplication/data/vos/isbns_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/persistance/dao/impls/books_by_list_name_dao_impl.dart';
import 'package:TheLibraryApplication/persistance/dao/impls/read_books_list_dao_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data/mock_data.dart';
import '../../network/book_data_agent_impl_mock.dart';
import '../../persistence/book_list_dao_impl_mock.dart';
import '../../persistence/books_by_list_name_dao_impl_mock.dart';
import '../../persistence/read_books_list_dao_impl_mock.dart';
import '../../persistence/shelf_dao_impl_mock.dart';

void main() {
  group("book_model_impl", () {
    var bookModel = BookModelImpl();
    setUp(() {
      bookModel.setDaosAndDataAgent(
        BookListDaoImplMock(),
        BooksByListNameDaoImplMock(),
        ReadBooksListDaoImplMock(),
        ShelfDaoImplMock(),
        BookDataAgentImplMock(),
      );
    });

    test("Get Overview Book List from network", () {
      expect(
        bookModel.getBookOverviewList(),
        completion(
          equals(
            getMockBookOverviewList(),
          ),
        ),
      );
    });

    test("Get Overview Book List from database", () {
      bookModel.getBookOverviewListFromDatabase();
      emits(
        getMockBookOverviewList(),
      );
    });

    test("Get books by list name from network", () {
      expect(
        bookModel.getBooksByListName(""),
        completion(
          equals(
            getMockBooksByListName(),
          ),
        ),
      );
    });

    test("Get books by list name from database", () {
      bookModel.getBooksByListNameFromDatabase("");
      emits(
        getMockBookOverviewList(),
      );
    });
    test("save read books to database", () async {
      bookModel.saveReadBooks(
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
      );
      await Future.delayed(Duration(milliseconds: 500));
      expect(bookModel.testSaveReadBooks(), getMockBooksByListName());
    });
    test("Get read books from database", () {
      bookModel.getReadBooksFromDatabase();
      emits(
        getMockBooksByListName(),
      );
    });

    test("Get search book list from network", () {
      expect(
        bookModel.getSearchBooksList(""),
        completion(
          equals(
            getMockSearchBooksList(),
          ),
        ),
      );
    });

    test("Get shelf list from database", () {
      bookModel.getShelfListFromDatabase();
      emits(
        getMockShelves(),
      );
    });

    test("save shelf to database", () async {
      bookModel.saveShelf(
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
        ),
      );
      await Future.delayed(Duration(milliseconds: 500));
      expect(
        bookModel.testSaveAndDeleteShelf(),
        getMockShelves(),
      );
    });

    test("delete shelf from database", () async {
      bookModel.deleteShelf(
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
        ),
      );
      await Future.delayed(Duration(milliseconds: 500));
      expect(
        bookModel.testSaveAndDeleteShelf(),
        [],
      );
    });
  });
}
