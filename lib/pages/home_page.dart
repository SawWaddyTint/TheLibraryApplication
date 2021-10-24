import 'package:TheLibraryApplication/bloc/home_page_bloc_with_provider.dart';

import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/pages/add_to_shelves_page.dart';
import 'package:TheLibraryApplication/pages/book_details_page.dart';
import 'package:TheLibraryApplication/pages/search_books_page.dart';

import 'package:TheLibraryApplication/resources/colors.dart';

import 'package:TheLibraryApplication/pages/see_more_audiobooks_page.dart';
import 'package:TheLibraryApplication/pages/see_more_books.dart';
import 'package:TheLibraryApplication/view_items/book_view.dart';

import 'package:TheLibraryApplication/view_items/list_tile_view.dart';
import 'package:TheLibraryApplication/view_items/searchbar_view.dart';
import 'package:TheLibraryApplication/view_items/tab_name_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomePageBlocWithProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarView(16.0, () {
                _navigateToSearchBooksPage(context);
              }),

              Selector<HomePageBlocWithProvider, List<BookVO>?>(
                selector: (context, bloc) => bloc.readBookList,
                builder: (BuildContext context, readBookList, child) {
                  return (readBookList != null &&
                          readBookList != [] &&
                          (readBookList.isNotEmpty))
                      ? CarouselSliderView(readBookList,)
                      : SizedBox(
                          height: 0.1,
                        );
                },
              ),

              SizedBox(
                height: 30.0,
              ),
              Selector<HomePageBlocWithProvider, List<BookListVO>?>(
                selector: (context, bloc) => bloc.bookLists,
                builder: (BuildContext context, bookLists, child) {
                  return (bookLists != null)
                      ? TabBarAndBookListView(
                          [],
                          bookLists,
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),

              // SizedBox(
              //   height: 20.0,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

_navigateToSearchBooksPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchBooksPage(),
    ),
  );
}

class EbooksHorizontalListView extends StatelessWidget {
  final BookListVO? booklist;
  EbooksHorizontalListView(this.booklist);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToSeeMoreBooksPage(
            context, booklist?.listNameEncoded, booklist?.displayName);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    booklist?.displayName ?? "",
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
              itemCount: booklist?.books?.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: BookView(
                    150.0,
                    100,
                    () {
                      showActionSheetForBooks(context, booklist?.books?[index]);
                    },
                    bookMargin: 8.0,
                    book: booklist?.books?[index],
                    key: Key((booklist?.listName?.split(" ").join("_").toUpperCase()??"")+"_"+(booklist?.books?[index]?.title?.split(" ").join("_")??"")),
                  ),
                  onTap: () {
                    _navigateToBookDetailPage(context, booklist?.books?[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

_navigateToBookDetailPage(BuildContext context, BookVO? book) {
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
  HomePageBlocWithProvider bloc =
      Provider.of<HomePageBlocWithProvider>(context, listen: false);
  bloc.saveToReadBooks(book);
}

class AudiobooksHorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToSeeMoreAudioBooksPage(context);
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
            child: ListView.builder(
              padding: EdgeInsets.only(left: 18.0),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return BookView(
                  120,
                  120,
                  () {
                    showActionSheetForAudiobooks(context);
                  },
                  bookMargin: 8.0,
                  showHeadset: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

_navigateToSeeMoreAudioBooksPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SeeMoreAudiobooksPage(),
    ),
  );
}

void showActionSheetForBooks(BuildContext context, BookVO? book) {
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

void showActionSheetForAudiobooks(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.1,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0.0, 0.0),
                    child: Container(
                      height: 55.0,
                      width: 55.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.network(
                          "https://images-na.ssl-images-amazon.com/images/I/41rQf+0zGiL._SX332_BO1,204,203,200_.jpg",
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
                        Text(
                          "Standing Tall:The Goh Chok Tong Years,Volumne 2",
                          style: TextStyle(
                            color: TITLE_COLOR,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                          // maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Shing Huei Peh, Chok Tong Goh . Ebook",
                            style: TextStyle(
                              color: LABEL_COLOR,
                              fontSize: 12.0,
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
                "Free Sample",
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

void showActionSheetForCarouselSlider(BuildContext context, BookVO? book) {
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
                          book?.bookImage ??
                              "https://p.kindpng.com/picc/s/84-843028_book-clipart-square-blank-book-cover-clip-art.png",
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
                    child: Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
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
                onTap: () {
                  _navigateToAddToShelvesPage(context, book, 1);
                },
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

_navigateToSeeMoreBooksPage(
    BuildContext context, String? listNameEncoded, String? displayName) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          SeeMoreBooksPage(listNameEncoded ?? "", displayName ?? ""),
    ),
  );
}

_navigateToAddToShelvesPage(BuildContext context, BookVO? book, int flag) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddToShelvesPage(book, flag),
    ),
  );
}

class TabBarAndBookListView extends StatelessWidget {
  TabBarAndBookListView(this.tabNameList, this.bookLists);

  final List<String>? tabNameList;
  final List<BookListVO>? bookLists;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: 2, // length of tabs
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
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
              Selector<HomePageBlocWithProvider, List<BookListVO>?>(
                selector: (context, bloc) => bloc.bookLists,
                builder: (BuildContext context, bookLists, child) {
                  return (bookLists != null)
                      ? Container(
                          height: 5.7 * 840.toDouble(), //height of TabBarView
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.5),
                            ),
                          ),
                          child: TabBarView(
                            children: <Widget>[
                              (bookLists != null &&
                                      bookLists != [] &&
                                      (bookLists.isNotEmpty))
                                  ? EbooksView(bookLists)
                                  : Padding(
                                      padding: EdgeInsets.only(top: 14.0),
                                      child: SizedBox(
                                        height: 20.0,
                                        width: 20.0,
                                        // child: CircularProgressIndicator(),
                                      ),
                                    ),
                              AudiobooksView(),
                            ],
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class AudiobooksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 840.0,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return AudiobooksHorizontalListView();
        },
      ),
    );
  }
}

class EbooksView extends StatelessWidget {
  final List<BookListVO> bookLists;
  EbooksView(this.bookLists);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 840.0,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: bookLists.length,
        itemBuilder: (BuildContext context, int index) {
          return EbooksHorizontalListView(bookLists[index]);
        },
      ),
    );
  }
}

class CarouselSliderView extends StatelessWidget {
  final List<BookVO>? readBookLists;
  CarouselSliderView(this.readBookLists);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.0,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 220.0,
            viewportFraction: 0.5,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
          ),
          items: readBookLists?.map((book) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(child: CarouselSliderItemView(book,key: Key("Carousel".toUpperCase()+"_"+(book.title??"").split(" ").join("_"),),),
                  onTap: () {
                    showActionSheetForCarouselSlider(context, book);
                  },);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CarouselSliderItemView extends StatelessWidget {
  final BookVO book;
  const CarouselSliderItemView(this.book,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                book.bookImage ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 25.0,
                width: 70.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(63, 64, 66, 0.8),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Text(
                    "Sample",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          CarouselBookActionButton(book: book),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 18.0),
              child: Container(
                height: 25.0,
                width: 25.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(63, 64, 66, 0.8),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Icon(
                  Icons.download_done_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(LABEL_COLOR),
                value: 10.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselBookActionButton extends StatelessWidget {
  const CarouselBookActionButton({
    Key? key,
    required this.book,
  }) : super(key: key);

  final BookVO book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child:
                Icon(Icons.more_horiz, color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        showActionSheetForCarouselSlider(context, book);
      },
    );
  }
}
