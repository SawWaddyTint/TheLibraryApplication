import 'package:TheLibraryApplication/bloc/search_books_page_bloc_with_provider.dart';

import 'package:TheLibraryApplication/components/debouncer.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';
import 'package:TheLibraryApplication/pages/add_to_shelves_page.dart';
import 'package:TheLibraryApplication/pages/book_details_page.dart';
import 'package:TheLibraryApplication/resources/colors.dart';
import 'package:TheLibraryApplication/pages/see_more_books.dart';
import 'package:TheLibraryApplication/view_items/book_view.dart';
import 'package:TheLibraryApplication/view_items/list_tile_view.dart';
import 'package:TheLibraryApplication/view_items/tab_name_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBooksPage extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  final debouncer = Debouncer(milliseconds: 900);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SearchBooksPageBlocWithProvider(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                BackButtonView(),
                SearchFieldView(textController, debouncer),
              ],
            ),
          ),
          body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [],
                    ),
                  ),
                  SearchedBookListsView(),
                  SearchedBookListsSubmittedView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchedBookListsSubmittedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<SearchBooksPageBlocWithProvider, bool>(
        selector: (context, bloc) => bloc.showSubmittedList,
        builder: (BuildContext context, showSubmittedList, child) {
          return Visibility(
            visible: showSubmittedList,
            child: DefaultTabController(
              length: 2, // length of tabs
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    // margin: EdgeInsets.only(top: 8.0),
                    child: TabBar(
                      indicatorColor: APP_THEME_COLOR,
                      unselectedLabelColor: LABEL_COLOR,
                      labelColor: APP_THEME_COLOR,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Tab(
                          child: TabNameView("Ebooks"),
                        ),
                        Tab(
                          child: TabNameView("Audiobooks"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 5.7 * 840.toDouble(), //height of TabBarView
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: Selector<SearchBooksPageBlocWithProvider,
                        List<SearchBookVO>?>(
                      selector: (context, bloc) => bloc.searchBooksList,
                      builder: (BuildContext context, searchBooksList, child) {
                        return TabBarView(
                          children: <Widget>[
                            Selector<SearchBooksPageBlocWithProvider, bool>(
                                selector: (context, bloc) => bloc.noData,
                                builder: (BuildContext context, noData, child) {
                                  return !noData
                                      ? EbooksHorizontalListView(
                                          searchBooksList)
                                      : Padding(
                                          padding: EdgeInsets.all(14.0),
                                          child: Text(
                                            "No results found!",
                                            style: TextStyle(
                                                color: LABEL_COLOR,
                                                fontSize: 18.0),
                                          ),
                                        );
                                }),
                            AudiobooksHorizontalListView(),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class SearchedBookListsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<SearchBooksPageBlocWithProvider, bool>(
      selector: (context, bloc) => bloc.showSearchedList,
      builder: (BuildContext context, showSearchedList, child) {
        return Visibility(
          visible: showSearchedList,
          child: Selector<SearchBooksPageBlocWithProvider, List<SearchBookVO>?>(
            selector: (context, bloc) => bloc.searchBooksList,
            builder: (BuildContext context, searchBooksList, child) {
              return (searchBooksList != null &&
                      searchBooksList != [] &&
                      (searchBooksList.isNotEmpty))
                  ? Column(
                      children: [
                        Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height,
                          child: Selector<SearchBooksPageBlocWithProvider,
                                  bool>(
                              selector: (context, bloc) => bloc.noData,
                              builder: (BuildContext context, noData, child) {
                                return !noData
                                    ? ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: searchBooksList.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15.0, 15.0, 15.0, 0),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 75,
                                                        width: 50,
                                                        // color: Colors.red,

                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          child: Image.network(
                                                            searchBooksList[
                                                                        index]
                                                                    .volumeInfo
                                                                    ?.imageLinks
                                                                    ?.thumbnail ??
                                                                "https://p.kindpng.com/picc/s/84-843028_book-clipart-square-blank-book-cover-clip-art.png",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16.0,
                                                      ),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                searchBooksList[
                                                                            index]
                                                                        .volumeInfo
                                                                        ?.title ??
                                                                    "",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            6.0),
                                                                child: Text(
                                                                  searchBooksList[
                                                                              index]
                                                                          .volumeInfo
                                                                          ?.subtitle ??
                                                                      "",
                                                                  style: TextStyle(
                                                                      color:
                                                                          LABEL_COLOR,
                                                                      fontSize:
                                                                          13.0),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      // Spacer(),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    _navigateToBookDetailPage(
                                                        context,
                                                        searchBooksList[index]);
                                                    SearchBooksPageBlocWithProvider
                                                        bloc = Provider.of<
                                                                SearchBooksPageBlocWithProvider>(
                                                            context,
                                                            listen: false);
                                                    bloc.saveToReadBooks(
                                                        searchBooksList[index]);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : SizedBox(height: 0.1);
                              }),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        );
      },
    );
  }
}

class BackButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.arrow_back_ios,
        color: LABEL_COLOR,
        size: 20.0,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

class SearchFieldView extends StatelessWidget {
  SearchFieldView(this.textController, this.debouncer);

  final TextEditingController textController;
  final Debouncer debouncer;

  @override
  Widget build(BuildContext context) {
    return Selector<SearchBooksPageBlocWithProvider, bool>(
        selector: (context, bloc) => bloc.hasValue,
        builder: (BuildContext context, hasValue, child) {
          return Flexible(
            child: TextField(
              controller: textController,
              style: TextStyle(),
              decoration: InputDecoration(
                hintText: "Search Play Books ",
                border: InputBorder.none,
                suffix: GestureDetector(
                  child: Visibility(
                    visible: hasValue,
                    child: Icon(
                      Icons.clear_outlined,
                      color: LABEL_COLOR,
                      size: 20.0,
                    ),
                  ),
                  onTap: () {
                    onChanged(context, "");
                    textController.clear();
                  },
                ),
              ),
              onChanged: (value) => debouncer.run(() {
                onChanged(context, value);
              }),
              onSubmitted: (value) => onSubmitted(context, value),

              // maxLength: 50,
            ),
          );
        });
  }
}

class EbooksHorizontalListView extends StatelessWidget {
  final List<SearchBookVO>? bookList;
  EbooksHorizontalListView(this.bookList);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        // onTap: () {
        //   _navigateToSeeMoreBooksPage(
        //       context, booklist.listNameEncoded, booklist.displayName);
        // },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Results from Google Play",
                      style: TextStyle(
                        color: TITLE_COLOR,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: APP_THEME_COLOR,
                    size: 18.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 200.0, // Image plus title
              // width: 300.0,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 18.0),
                scrollDirection: Axis.horizontal,
                itemCount: bookList?.length,
                itemBuilder: (BuildContext context, int index) {
                  // return BookView(
                  //   8.0,
                  //   () {
                  //     showActionSheet(context);
                  //   },
                  //   150.0,
                  //   100.0,
                  //   // (movieId) {
                  //   //   onTapMovie(movieId);
                  //   // },
                  //   // movieList[index],
                  // );
                  return GestureDetector(
                    child: BookView(
                      150.0,
                      100,
                      () {
                        showActionSheetForBooks(context, bookList?[index]);
                      },
                      bookMargin: 8.0,
                      searchBook: bookList?[index],
                    ),
                    onTap: () {
                      _navigateToBookDetailPage(context, bookList?[index]);
                      SearchBooksPageBlocWithProvider bloc =
                          Provider.of<SearchBooksPageBlocWithProvider>(context,
                              listen: false);

                      bloc.saveToReadBooks(bookList?[index]);
                    },
                  );
                },
              ),
            ),
            // SizedBox(
            //   height: 6.0,
            // )
          ],
        ),
        onTap: () {});
  }
}

// _navigateToSeeMoreBooksPage(
//     BuildContext context, String listNameEncoded, String displayName) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => SeeMoreBooksPage(listNameEncoded, displayName),
//     ),
//   );
// }

_navigateToBookDetailPage(BuildContext context, SearchBookVO? book) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookDetailsPage(
        95,
        160,
        "Free Sample",
        searchBook: book,
      ),
    ),
  );
}

class AudiobooksHorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // _navigateToSeeMoreAudioBooksPage(context);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Audiobooks for you",
                    style: TextStyle(
                      color: TITLE_COLOR,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Spacer(),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: APP_THEME_COLOR,
                  size: 18.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 165.0,
            // width: 150.0,
            // width: 200.0,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 18.0),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return BookView(
                  120,
                  120,
                  () {
                    // showActionSheetForAudiobooks(context);
                  },
                  bookMargin: 8.0,
                  showHeadset: true,
                  // (movieId) {
                  //   onTapMovie(movieId);
                  // },
                  // movieList[index],
                );
                // return Container(
                //   margin: EdgeInsets.only(right: 10.0),
                //   // height: 80,
                //   width: 150,
                //   color: Colors.black12,
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void showActionSheetForBooks(BuildContext context, SearchBookVO? book) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.3,
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
                          book?.volumeInfo?.imageLinks?.thumbnail ?? "",
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
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            book?.volumeInfo?.title ?? "",
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
                            "${book?.volumeInfo?.authors?[0]} . Ebook",
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
                "Remove download",
                Icon(
                  Icons.remove_circle_outline,
                  color: LABEL_COLOR,
                ),
              ),
              ListTileView(
                "Delete from your library",
                Icon(
                  Icons.delete_outline,
                  color: LABEL_COLOR,
                ),
              ),
              InkWell(
                child: ListTileView(
                  "Add to shelves...",
                  Icon(
                    Icons.add,
                    color: LABEL_COLOR,
                  ),
                ),
                // onTap: () {
                //   _navigateToAddToShelvesPage(context, book, 1); // 1 for add
                // },
              ),
              ListTileView(
                "About this book",
                Icon(
                  Icons.book_outlined,
                  color: LABEL_COLOR,
                ),
              )
            ],
          ),
        );
      });
}

_navigateToAddToShelvesPage(BuildContext context, BookVO book, int flag) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddToShelvesPage(book, flag),
    ),
  );
}

onChanged(BuildContext context, String value) {
  SearchBooksPageBlocWithProvider bloc =
      Provider.of<SearchBooksPageBlocWithProvider>(context, listen: false);
  bloc.onChanged(value);
}

onSubmitted(BuildContext context, String value) {
  SearchBooksPageBlocWithProvider bloc =
      Provider.of<SearchBooksPageBlocWithProvider>(context, listen: false);
  bloc.onSubmitted(value);
}
