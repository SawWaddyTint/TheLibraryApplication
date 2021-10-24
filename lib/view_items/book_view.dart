import 'package:TheLibraryApplication/data/vos/book_details_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';
import 'package:TheLibraryApplication/resources/colors.dart';
import 'package:flutter/material.dart';

class BookView extends StatelessWidget {
  final double _height;
  final double _width;

  final Function tapMore;
  final double bookMargin;
  final bool showSample;
  final bool showDownload;
  final bool showHeadset;
  final BookVO? book;
  final SearchBookVO? searchBook;
  const BookView(this._height, this._width, this.tapMore,{
    Key? key,
    this.book,
    this.searchBook,
    // this.bookDetails,
    this.bookMargin = 0.0,
    this.showSample = false,
    this.showDownload = false,
    this.showHeadset = false
  }) : super(key: key);
  // final B bookDetails;

  // BookView(this._height, this._width, this.tapMore,
  //     {this.book,
  //     this.searchBook,
  //     // this.bookDetails,
  //     this.bookMargin = 0.0,
  //     this.showSample = false,
  //     this.showDownload = false,
  //     this.showHeadset = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: bookMargin),
      width: _width,
      child: Column(
        children: [
          Container(
            height: _height, //only image

            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      book?.bookImage ??
                          searchBook?.volumeInfo?.imageLinks?.thumbnail ??
                          "https://p.kindpng.com/picc/s/84-843028_book-clipart-square-blank-book-cover-clip-art.png",
                      // "https://images-na.ssl-images-amazon.com/images/I/41rQf+0zGiL._SX332_BO1,204,203,200_.jpg",

                      fit: BoxFit.fill,
                      // height: 200.0,
                    ),
                  ),
                ),
                Visibility(
                  visible: showSample,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 22.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(63, 64, 66, 0.8),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Center(
                          child: Text(
                            "Sample",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Icon(Icons.more_horiz, color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    this.tapMore();
                  },
                ),
                Visibility(
                  visible: showHeadset,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(6.0, 0, 0, 6.0),
                      child: Container(
                        height: 21.0,
                        width: 21.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(63, 64, 66, 0.8),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Icon(
                          Icons.headset,
                          color: Colors.white,
                          size: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: showDownload,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 6.0, 6.0),
                      child: Container(
                        height: 21.0,
                        width: 21.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(63, 64, 66, 0.8),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Icon(
                          Icons.download_done_outlined,
                          color: Colors.white,
                          size: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          (book?.title != null && book?.title != "")
              ? Text(
                  // book != null ? book.title : searchBook.volumeInfo.title,
                  book?.title ?? "",
                  // "test book",
                  style: TextStyle(
                    color: LABEL_COLOR,

                    // fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  // book != null ? book.title : searchBook.volumeInfo.title,
                  searchBook?.volumeInfo?.title ?? "",
                  // "test book",
                  style: TextStyle(
                    color: LABEL_COLOR,

                    // fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
          // Text(
          //   // book != null ? book.title : searchBook.volumeInfo.title,
          //   book?.title ?? "",
          //   // "test book",
          //   style: TextStyle(
          //     color: LABEL_COLOR,
          //
          //     // fontWeight: FontWeight.w500,
          //     fontSize: 12.0,
          //   ),
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          // )
        ],
      ),
    );
  }
}
