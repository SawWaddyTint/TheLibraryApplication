// import 'dart:html';

import 'package:TheLibraryApplication/data/vos/book_vo.dart';

import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';

import 'package:TheLibraryApplication/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookDetailsPage extends StatelessWidget {
  final double _width;
  final double _height;
  final String _text;
  final BookVO? bookDetails;
  final SearchBookVO? searchBook;
  final bool showBtnIcon;
  BookDetailsPage(this._width, this._height, this._text,
      {this.bookDetails, this.searchBook, this.showBtnIcon = false});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: LABEL_COLOR,
            size: 20.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: TitleView(),
        actions: [
          ActionButtonView(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0),
              child: (bookDetails != null)
                  ? BookImageAndTitleView(
                      _width,
                      _height,
                      bookDetails: bookDetails,
                    )
                  : BookImageAndTitleView(
                      _width,
                      _height,
                      sbBook: searchBook,
                    ),
            ),
            Divider(
              thickness: 0.8,
              height: 35.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 8.0),
              child: Row(
                children: [
                  BookDetailsScreenButtonView(
                    _text,
                    APP_THEME_COLOR,
                    Colors.white,
                    showBtnIcon: showBtnIcon,
                  ),
                  Spacer(),
                  BookDetailsScreenButtonView(
                    "Get the full book",
                    Colors.white,
                    APP_THEME_COLOR,
                    isGhostBtn: true,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.8,
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingView(),
                  SizedBox(
                    height: 15.0,
                  ),
                  BookDescriptionView(bookDetails?.description ??
                      searchBook?.volumeInfo?.description ??
                      "No Description Found"),
                  BookPublishedInfoView(bookDetails?.publisher ??
                      searchBook?.volumeInfo?.publisher ??
                      ""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: Icon(
          Icons.more_horiz,
          color: LABEL_COLOR,
          size: 22.0,
        ),
        onTap: () {},
      ),
    );
  }
}

class TitleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Text(
        "About this book",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class BookImageAndTitleView extends StatelessWidget {
  final double _width;
  final double _height;
  final BookVO? bookDetails;
  final SearchBookVO? sbBook;
  BookImageAndTitleView(this._width, this._height,
      {this.bookDetails, this.sbBook});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: _height,
          width: _width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Image.network(
              bookDetails?.bookImage ??
                  sbBook?.volumeInfo?.imageLinks?.thumbnail ??
                  "https://p.kindpng.com/picc/s/84-843028_book-clipart-square-blank-book-cover-clip-art.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          width: 18.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (bookDetails?.title != null && bookDetails?.title != "")
                  ? Text(
                      bookDetails?.title ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      sbBook?.volumeInfo?.title ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "${bookDetails?.author ?? sbBook?.volumeInfo?.authors?[0]}",
                      style: TextStyle(color: LABEL_COLOR),
                    ),  Text(
                      "Ebook . 336 pages",
                      style: TextStyle(color: LABEL_COLOR),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class BookPublishedInfoView extends StatelessWidget {
  final String publisher;
  BookPublishedInfoView(this.publisher);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Published",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          children: [
            Text(
              "2021-08-05 .",
              style: TextStyle(
                color: LABEL_COLOR,
                fontSize: 14.0,
              ),
            ),
            Text(
              "$publisher",
              style: TextStyle(
                color: LABEL_COLOR,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 14.0,
        ),
      ],
    );
  }
}

class BookDescriptionView extends StatelessWidget {
  final String description;
  BookDescriptionView(this.description);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          description,
          style: TextStyle(
            color: LABEL_COLOR,
          ),
        ),
        SizedBox(
          height: 24.0,
        ),
      ],
    );
  }
}

class RatingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "4.4",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: RatingBar.builder(
                initialRating: 4.5,
                itemBuilder: (BuildContext context, int index) {
                  return Icon(
                    Icons.star,
                    color: Colors.black,
                  );
                },
                itemSize: 16.0,
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            )
          ],
        ),
        Text(
          "59 ratings on Google Play",
          style: TextStyle(
            color: LABEL_COLOR,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}

class BookDetailsScreenButtonView extends StatelessWidget {
  final String titleText;
  final Color bgColor;
  final Color textColor;
  final bool isGhostBtn;
  final bool showBtnIcon;
  BookDetailsScreenButtonView(this.titleText, this.bgColor, this.textColor,
      {this.isGhostBtn = false, this.showBtnIcon = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.0,
      width: 150.0,
      padding: EdgeInsets.symmetric(
        horizontal: 6.0,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.0),
        border: (isGhostBtn)
            ? Border.all(
                color: Colors.grey,
                width: 0.3,
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: showBtnIcon,
            child: Icon(
              Icons.play_arrow_sharp,
              color: Colors.white,
              size: 14.0,
            ),
          ),
          SizedBox(
            width: 4.0,
          ),
          Text(
            titleText,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w500, fontSize: 13.0),
          ),
        ],
      ),
    );
  }
}
