import 'package:TheLibraryApplication/data/vos/access_info_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/buy_links_vo.dart';
import 'package:TheLibraryApplication/data/vos/epub_vo.dart';
import 'package:TheLibraryApplication/data/vos/image_link_vo.dart';
import 'package:TheLibraryApplication/data/vos/industry_identifier_vo.dart';
import 'package:TheLibraryApplication/data/vos/isbns_vo.dart';
import 'package:TheLibraryApplication/data/vos/panelization_summary_vo.dart';
import 'package:TheLibraryApplication/data/vos/pdf_vo.dart';
import 'package:TheLibraryApplication/data/vos/reading_mode_vo.dart';
import 'package:TheLibraryApplication/data/vos/sale_info_vo.dart';
import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';
import 'package:TheLibraryApplication/data/vos/search_info_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/data/vos/volume_info_vo.dart';

List<BookListVO> getMockBookOverviewList() {
  return [
    BookListVO(
      704,
      "Combined Print and E-Book Fiction",
      "combined-print-and-e-book-fiction",
      "Combined Print & E-Book Fiction",
      "WEEKLY",
      null,
      null,
      null,
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
        )
      ],
    )
  ];
}

List<BookVO> getMockBooksByListName() {
  return [
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
        BuyLinksVO(
            "Amazon", "https://www.amazon.com/dp/0735222355?tag=NYTBSREV-20")
      ],
      1,
      [
        IsbnsVO(
          "1984821520",
          "9781984821522",
        )
      ],
    )
  ];
}

List<SearchBookVO> getMockSearchBooksList() {
  return [
    SearchBookVO(
        "books#volume",
        "LTUeAwAAQBAJ",
        "DLvtFUp3NCo",
        "https://www.googleapis.com/books/v1/volumes/LTUeAwAAQBAJ",
        VolumeInfoVO(
            "Basics Interactive Design: User Experience Design",
            "Creating Designs Users Really Love",
            [
              "Gavin Allanwood",
              "Peter Beare",
            ],
            "A&C Black",
            "2014-04-24",
            "By putting people at the centre of interactive design, user experience (UX) techniques are now right at the heart of digital media design and development. As a designer, you need to create work that will impact positively on everyone who is exposed to it. Whether it's passive and immutable or interactive and dynamic, the success of your design will depend largely on how well the user experience is constructed.User Experience Design shows how researching and understanding users' expectations and motivations can help you develop effective, targeted designs. The authors explore the use of scenarios, personas and prototyping in idea development, and will help you get the most out of the latest tools and techniques to produce interactive designs that users will love.With practical projects to get you started, and stunning examples from some of today's most innovative studios, this is an essential introduction to modern UXD.",
            [
              IndustryIdentifierVO("ISBN_13", "9782940496136"),
              IndustryIdentifierVO("ISBN_10", "2940496137")
            ],
            ReadingModeVO(false, true),
            184,
            "BOOK",
            "NOT_MATURE",
            false,
            "preview-1.0.0",
            PanelizationSummaryVO(false, false),
            ["Design"],
            ImageLinkVO(
                "http://books.google.com/books/content?id=LTUeAwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                "http://books.google.com/books/content?id=LTUeAwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"),
            "en",
            "http://books.google.com/books?id=LTUeAwAAQBAJ&printsec=frontcover&dq=user&hl=&cd=3&source=gbs_api",
            "http://books.google.com/books?id=LTUeAwAAQBAJ&dq=user&hl=&source=gbs_api",
            "https://books.google.com/books/about/Basics_Interactive_Design_User_Experienc.html?hl=&id=LTUeAwAAQBAJ"),
        SaleInfoVO("MM", "NOT_FOR_SALE", false),
        AccessInfoVO(
            "MM",
            "PARTIAL",
            true,
            false,
            "ALLOWED",
            EpubVO(false),
            PdfVO(false),
            "http://play.google.com/books/reader?id=LTUeAwAAQBAJ&hl=&printsec=frontcover&source=gbs_api",
            "SAMPLE",
            false),
        SearchInfoVO(
            textSnippet:
                "The authors explore the use of scenarios, personas and prototyping in idea development, and will help you get the most out of the latest tools and techniques to produce interactive designs that users will love.With practical projects to get ..."))
  ];
}

List<ShelfVO> getMockShelves() {
  return [
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
  ];
}
List<BookVO> getMockReadBooks() {
  return [
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
    BookVO(
      "",
      "https://www.amazon.com/dp/0063142937?tag=NYTBSREV-20",
      "",
      "Stephanie Grisham",
      "https://storage.googleapis.com/du-prd/books/images/9780063142930.jpg",
      331,
      500,
      "",
      "by Stephanie Grisham",
      "",
      "2021-11-21 22:12:27",
      "The former White House press secretary and communications director recounts her time in the Trump inner circle.",
      "",
      "0.00",
      "0063142937",
      "9780063142930",
      "nyt://book/0f544269-91b1-56b7-9928-9f0bd49b6e3c",
      "Harper",
      2,
      0,
      "",
      "I'LL TAKE YOUR QUESTIONS NOW",
      "2021-10-15 20:13:01",
      1,
      [
        BuyLinksVO("Amazon",
            "https://www.amazon.com/dp/0063142937?tag=NYTBSREV-20")
      ],
      1,
      [
        IsbnsVO(
          "0063142937",
          "9780063142930",
        )
      ],
    ),
  ];
}