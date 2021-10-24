import 'package:TheLibraryApplication/bloc/see_more_books_bloc_with_provider.dart';

import 'package:TheLibraryApplication/data/vos/book_details_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/books_by_list_name_vo.dart';
import 'package:TheLibraryApplication/pages/book_details_page.dart';
import 'package:TheLibraryApplication/persistance/dao/books_by_list_name_dao.dart';
import 'package:TheLibraryApplication/resources/colors.dart';

import 'package:TheLibraryApplication/view_items/book_view.dart';
import 'package:TheLibraryApplication/view_items/list_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeMoreBooksPage extends StatelessWidget {
  // const SeeMoreBooksPage({ Key? key }) : super(key: key);
  final String listNameEncoded;
  final String displayName;

  SeeMoreBooksPage(this.listNameEncoded, this.displayName);
  @override
  Widget build(BuildContext context) {
    // final orientation = MediaQuery.of(context).orientation;
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          SeeMoreBooksBlocWithProvider(listName: listNameEncoded),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: TITLE_COLOR,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            displayName,
            style: TextStyle(
              color: TITLE_COLOR,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Selector<SeeMoreBooksBlocWithProvider, List<BookVO>?>(
            selector: (context, bloc) => bloc.readBooks,
            builder: (BuildContext context, readBooks, child) {
              return readBooks != null && readBooks != []
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.01),
                        ),
                        itemCount: readBooks.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: BookView(
                              230,
                              100,
                              () {
                                _showActionSheet(context, readBooks[index]);
                              },
                              book: readBooks[index],
                            ),
                            onTap: () {
                              _navigateToBookDetailPage(
                                  context, readBooks[index]);

                              SeeMoreBooksBlocWithProvider bloc =
                                  Provider.of<SeeMoreBooksBlocWithProvider>(
                                      context,
                                      listen: false);
                              bloc.saveToReadBooks(readBooks[index]);
                            },
                          );
                        },
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }),
      ),
    );
  }
}

_navigateToBookDetailPage(BuildContext context, BookVO book) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookDetailsPage(
        95,
        160,
        "Free Sample",
        bookDetails: book,
      ),
    ),
  );
}

void _showActionSheet(BuildContext context, BookVO? book) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.3,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0.0, 0.0),
                    child: Container(
                      height: 70.0,
                      width: 45.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.network(
                          book?.bookImage ?? "",
                          fit: BoxFit.cover,
                          // height: 200.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 14.0),
                          child: Text(
                            book?.title ?? "",
                            style: TextStyle(
                              color: TITLE_COLOR,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "${book?.author} . Ebook",
                            style: TextStyle(
                              color: LABEL_COLOR,
                              fontSize: 14.0,
                              // fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1.0,
                height: 20.0,
              ),
              ListTileView(
                "Free sample",
                Icon(
                  Icons.add_to_photos_outlined,
                  color: LABEL_COLOR,
                ),
              ),
              ListTileView(
                "About this book",
                Icon(
                  Icons.book_outlined,
                  color: LABEL_COLOR,
                ),
              ),
            ],
          ),
        );
      });
}
