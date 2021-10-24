import 'package:TheLibraryApplication/bloc/shelf_details_page_bloc_with_provider.dart.dart';
import 'package:TheLibraryApplication/bloc/your_books_page_bloc_with_provider.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/pages/add_to_shelves_page.dart';
import 'package:TheLibraryApplication/pages/library_page.dart';
import 'package:TheLibraryApplication/pages/your_shelves_page.dart';
import 'package:TheLibraryApplication/resources/colors.dart';
import 'package:TheLibraryApplication/view_items/book_view.dart';
import 'package:TheLibraryApplication/view_items/list_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ShelfDetailsPage extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  int _radioSelected = 1;
  int _sortedRadioSelected = 1;
  final ShelfVO? shelf;
  ShelfDetailsPage(this.shelf);

  @override
  Widget build(BuildContext context) {
    textController.text = shelf?.shelfName ?? "";
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          ShelfDetailsPageBlocWithProvider(shelf: shelf),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: AppBarActionButtonsView(shelf, textController),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Selector<ShelfDetailsPageBlocWithProvider, bool>(
                  selector: (context, bloc) => bloc.showSelectedFilter,
                  builder: (BuildContext context, showSelectedFilter, child) {
                    return ShelfActionView(() {
                      showDiaLogForDeleteShelf(
                        context,
                        shelf,
                      );
                    },
                        //     (){
                        //       deleteShelf(context, shelf);
                        //     },
                        () {
                      clickRename(context);
                    }, shelf);
                  }),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Selector<ShelfDetailsPageBlocWithProvider, bool>(
                  selector: (context, bloc) => bloc.renameFlag,
                  builder: (BuildContext context, renameFlag, child) {
                    return renameFlag
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: textController,
                              autofocus: true,
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                hintText: "Shelf name ",
                                suffix: GestureDetector(
                                  child: Container(
                                    height: 21.0,
                                    width: 21.0,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(
                                          63,
                                          64,
                                          66,
                                          0.8,
                                        ),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.clear_outlined,
                                      color: Colors.white,
                                      size: 14.0,
                                    ),
                                  ),
                                  onTap: () {
                                    ShelfDetailsPageBlocWithProvider bloc =
                                        Provider.of<
                                                ShelfDetailsPageBlocWithProvider>(
                                            context,
                                            listen: false);
                                    bloc.onChanged("");
                                    textController.clear();
                                  },
                                ),
                              ),
                              onChanged: (value) => onChanged(context, value),
                              onSubmitted: (value) =>
                                  _onSubmitted(context, shelf, value),
                              maxLength: 50,
                            ),
                          )
                        : SizedBox(
                            height: 0.1,
                          );
                  }),
              Selector<ShelfDetailsPageBlocWithProvider, ShelfVO?>(
                  selector: (context, bloc) => bloc.detailsShelf,
                  builder: (BuildContext context, detailsShelf, child) {
                    return ShelfNameAndBooksCountView(detailsShelf);
                  }),
              Divider(
                thickness: 1.0,
                height: 22.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22.0, 14.0, 0.0, 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Row(
                            children: [
                              Selector<ShelfDetailsPageBlocWithProvider, bool>(
                                selector: (context, bloc) =>
                                    bloc.showSelectedFilter,
                                builder: (BuildContext context,
                                    showSelectedFilter, child) {
                                  return SortedByView(
                                    (value) =>
                                        getSortedByRadioValue(context, value),
                                    _sortedRadioSelected,
                                  );
                                },
                              ),
                              Spacer(),
                              Selector<ShelfDetailsPageBlocWithProvider, int>(
                                selector: (context, bloc) =>
                                    bloc.layoutIndexForBooks,
                                builder: (BuildContext context,
                                    layoutIndexForBooks, child) {
                                  return (layoutIndexForBooks == 1)
                                      ? ChooseBooksView(
                                          Icon(
                                            Icons.grid_on_outlined,
                                            size: 18.0,
                                            color: LABEL_COLOR,
                                          ), (index) {
                                          sendIndexToBloc(context, index);
                                        }, _radioSelected)
                                      : (layoutIndexForBooks == 2)
                                          ? ChooseBooksView(
                                              Icon(
                                                Icons.list_alt,
                                                size: 19.0,
                                                color: LABEL_COLOR,
                                              ), (index) {
                                              sendIndexToBloc(context, index);
                                            }, _radioSelected)
                                          : ChooseBooksView(
                                              Icon(
                                                Icons.list_alt,
                                                size: 19.0,
                                                color: LABEL_COLOR,
                                              ), (radioIndx) {
                                              sendIndexToBloc(
                                                  context, radioIndx);
                                            }, _radioSelected);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Selector<ShelfDetailsPageBlocWithProvider, int>(
                    selector: (context, bloc) => bloc.layoutIndexForBooks,
                    builder:
                        (BuildContext context, layoutIndexForBooks, child) {
                      return (layoutIndexForBooks == 1)
                          ? BooksListView()
                          : (layoutIndexForBooks == 2)
                              ? BooksLargeGridView(
                                  (book, shelf) {
                                    _showActionSheetForBooks(
                                      context,
                                      book,
                                      shelf,
                                      () {
                                        _removeFromCurrentShelf(context, book);
                                      },
                                      () {
                                        _deleteFromLibrary(context, book);
                                      },
                                    );
                                  },
                                )
                              : BooksSmallGridView(
                                  (book, shelf) {
                                    _showActionSheetForBooks(
                                      context,
                                      book,
                                      shelf,
                                      () {
                                        _removeFromCurrentShelf(context, book);
                                      },
                                      () {
                                        _deleteFromLibrary(context, book);
                                      },
                                    );
                                  },
                                );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarActionButtonsView extends StatelessWidget {
  AppBarActionButtonsView(this.shelf, this.textController);

  final ShelfVO? shelf;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Selector<ShelfDetailsPageBlocWithProvider, bool>(
      selector: (context, bloc) => bloc.renameFlag,
      builder: (BuildContext context, renameFlag, child) {
        return Row(
          children: [
            Visibility(
              visible: renameFlag,
              child: CreateShelfButtonInShelfDetails(
                  shelf: shelf, textController: textController),
            ),
            Visibility(
              visible: !renameFlag,
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: LABEL_COLOR,
                    size: 20.0,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class CreateShelfButtonInShelfDetails extends StatelessWidget {
  const CreateShelfButtonInShelfDetails({
    Key? key,
    required this.shelf,
    required this.textController,
  }) : super(key: key);

  final ShelfVO? shelf;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: InkWell(
        child: Container(
          height: 16.0,
          width: 16.0,
          child: Image.asset(
            "lib/assets/tick.png",
            fit: BoxFit.fill,
            color: Colors.blue,
          ),
        ),
        onTap: () {
          ShelfDetailsPageBlocWithProvider bloc =
              Provider.of<ShelfDetailsPageBlocWithProvider>(context,
                  listen: false);
          bloc.checkShelfNameForShelfDetails(context,
              ShelfVO(shelf?.id ?? "", textController.text, shelf?.bookList));
          // Navigator.pop(context);
          // checkShelfName(context,
          //     ShelfVO("", textController.text, []));
        },
      ),
    );
  }
}

getSortedByRadioValue(BuildContext context, int value) {
  debugPrint("Choosen Sorted By value is  " + value.toString());
  ShelfDetailsPageBlocWithProvider bloc =
      Provider.of<ShelfDetailsPageBlocWithProvider>(context, listen: false);
  bloc.sortedBySelectedIndex(value);
}

class ShelfActionView extends StatelessWidget {
  final Function deleteShelf;
  final Function clickRename;
  final ShelfVO? shelf;
  ShelfActionView(this.deleteShelf, this.clickRename, this.shelf);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: IconButton(
        icon: Icon(
          Icons.more_horiz,
          color: LABEL_COLOR,
          size: 22.0,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (builder) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            shelf?.shelfName ?? "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          height: 20.0,
                        ),
                        Column(
                          children: [
                            InkWell(
                              child: ListTileView(
                                "Rename shelf",
                                Icon(
                                  Icons.edit_outlined,
                                  color: LABEL_COLOR,
                                ),
                              ),
                              onTap: () {
                                clickRename();
                              },
                            ),
                            InkWell(
                              child: ListTileView(
                                "Delete Shelf",
                                Icon(
                                  Icons.delete_outline,
                                  color: LABEL_COLOR,
                                ),
                              ),
                              onTap: () {
                                deleteShelf();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ShelfNameAndBooksCountView extends StatelessWidget {
  final ShelfVO? shelf;
  ShelfNameAndBooksCountView(this.shelf);

  @override
  Widget build(BuildContext context) {
    return Selector<ShelfDetailsPageBlocWithProvider, bool>(
        selector: (context, bloc) => bloc.renameFlag,
        shouldRebuild: (previous, next) => true,
        builder: (BuildContext context, renameFlag, child) {
          return Visibility(
            visible: !renameFlag,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      shelf?.shelfName ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  (shelf?.bookList?.length == 0 || shelf?.bookList?.length == 1)
                      ? Text(
                          "${shelf?.bookList?.length} book",
                          style: TextStyle(
                            color: LABEL_COLOR,
                            fontSize: 16.0,
                          ),
                        )
                      : Text(
                          "${shelf?.bookList?.length} books",
                          style: TextStyle(
                            color: LABEL_COLOR,
                            fontSize: 16.0,
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }
}

void getSelectedItems(BuildContext context, String selected) {
  ShelfDetailsPageBlocWithProvider bloc =
      Provider.of<ShelfDetailsPageBlocWithProvider>(context, listen: false);
  bloc.getSelectedItems(selected);
}

void sendIndexToBloc(BuildContext context, int radioIndex) {
  ShelfDetailsPageBlocWithProvider bloc =
      Provider.of<ShelfDetailsPageBlocWithProvider>(context, listen: false);
  bloc.changeLayoutStyle(radioIndex);
}

removeFilters(BuildContext context) {
  ShelfDetailsPageBlocWithProvider bloc =
      Provider.of<ShelfDetailsPageBlocWithProvider>(context, listen: false);
  bloc.removeFilters();
}

class SortedByView extends StatelessWidget {
  final Function getSortedByRadioValue;
  int _sortedRadioSelected;
  SortedByView(this.getSortedByRadioValue, this._sortedRadioSelected);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Icon(
            Icons.sort,
            color: LABEL_COLOR,
            size: 22.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Selector<ShelfDetailsPageBlocWithProvider, String>(
            selector: (context, bloc) => bloc.sortedType,
            shouldRebuild: (previous, next) => true,
            builder: (BuildContext context, sortedType, child) {
              return Text(
                "Sort by: $sortedType",
                style: TextStyle(
                  color: LABEL_COLOR,
                  fontSize: 15.0,
                ),
              );
            },
          ),
        ],
      ),
      onTap: () {
        showModalBottomSheet(
          useRootNavigator: true,
          context: context,
          builder: (BuildContext context) {
            return ChangeNotifierProvider(
              create: (BuildContext context) =>
                  ShelfDetailsPageBlocWithProvider(),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return ChangeNotifierProvider(
                    create: (BuildContext context) =>
                        ShelfDetailsPageBlocWithProvider(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.8,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30.0, 12.0, 0.0, 0.0),
                              child: Text(
                                "View as",
                                style: TextStyle(
                                    color: LABEL_COLOR,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          Divider(
                            thickness: 1.0,
                            height: 28.0,
                          ),
                          Column(
                            children: [
                              RadioListTile(
                                value: 1,
                                groupValue: _sortedRadioSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _sortedRadioSelected = value as int;
                                  });

                                  _close(context);
                                  getSortedByRadioValue(value);
                                },
                                title: Text("Recently opened"),
                              ),
                              RadioListTile(
                                value: 2,
                                groupValue: _sortedRadioSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _sortedRadioSelected = value as int;
                                  });
                                  // getRadioValue(value);
                                  _close(context);
                                  getSortedByRadioValue(value);
                                },
                                title: Text("Title"),
                              ),
                              RadioListTile(
                                value: 3,
                                groupValue: _sortedRadioSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _sortedRadioSelected = value as int;
                                  });
                                  _close(context);
                                  getSortedByRadioValue(value);
                                },
                                title: Text("Author"),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class BooksSmallGridView extends StatelessWidget {
  final Function tapMore;
  BooksSmallGridView(this.tapMore);
  @override
  Widget build(BuildContext context) {
    return Selector<ShelfDetailsPageBlocWithProvider, List<BookVO>?>(
        selector: (context, bloc) => bloc.detailsShelf?.bookList,
        shouldRebuild: (previous, next) => true,
        builder: (BuildContext context, addedBooks, child) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 0.92),
                ),
                itemCount: addedBooks?.length,
                itemBuilder: (context, index) {
                  return Selector<ShelfDetailsPageBlocWithProvider, ShelfVO?>(
                      selector: (context, bloc) => bloc.detailsShelf,
                      shouldRebuild: (previous, next) => true,
                      builder: (BuildContext context, shelf, child) {
                        return BookView(
                          150,
                          100,
                          () {
                            tapMore(addedBooks?[index], shelf);
                          },
                          showSample: true,
                          showDownload: true,
                          book: addedBooks?[index],
                        );
                      });
                },
              ),
            ),
          );
        });
  }
}

class BooksLargeGridView extends StatelessWidget {
  final Function tapMore;
  BooksLargeGridView(this.tapMore);
  @override
  Widget build(BuildContext context) {
    return Selector<ShelfDetailsPageBlocWithProvider, List<BookVO>?>(
        selector: (context, bloc) => bloc.detailsShelf?.bookList,
        shouldRebuild: (previous, next) => true,
        builder: (BuildContext context, addedBooks, child) {
          return Container(
            height: 2000.0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 11.0,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.01),
                ),
                itemCount: addedBooks?.length,
                itemBuilder: (context, index) {
                  return Selector<ShelfDetailsPageBlocWithProvider, ShelfVO?>(
                      selector: (context, bloc) => bloc.detailsShelf,
                      shouldRebuild: (previous, next) => true,
                      builder: (BuildContext context, shelf, child) {
                        return BookView(
                          230,
                          100,
                          () {
                            tapMore(addedBooks?[index], shelf);
                          },
                          showDownload: true,
                          showSample: true,
                          book: addedBooks?[index],
                        );
                      });
                },
              ),
            ),
          );
        });
  }
}

class BooksListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<ShelfDetailsPageBlocWithProvider, ShelfVO?>(
        selector: (context, bloc) => bloc.detailsShelf,
        shouldRebuild: (previous, next) => true,
        builder: (BuildContext context, detailsShelf, child) {
          return (detailsShelf?.bookList != null &&
                  detailsShelf?.bookList != [] &&
                  (detailsShelf?.bookList?.isNotEmpty ?? false))
              ? ListView.builder(
                  itemCount: detailsShelf?.bookList?.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 15.0, 0.0, 0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 75,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Image.network(
                                    detailsShelf?.bookList?[index].bookImage ??
                                        "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                width: 176.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        detailsShelf?.bookList?[index].title ??
                                            "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          "${detailsShelf?.bookList?[index].author} \nEbook . Sample",
                                          style: TextStyle(
                                              color: LABEL_COLOR,
                                              fontSize: 13.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.download_done_outlined,
                                        color: LABEL_COLOR,
                                        size: 16.0,
                                      ),
                                      onPressed: () {},
                                    ),
                                    Selector<ShelfDetailsPageBlocWithProvider,
                                            ShelfVO?>(
                                        selector: (context, bloc) =>
                                            bloc.detailsShelf,
                                        shouldRebuild: (previous, next) => true,
                                        builder: (BuildContext context,
                                            detailsShelf, child) {
                                          return IconButton(
                                            icon: Icon(
                                              Icons.more_horiz,
                                              color: LABEL_COLOR,
                                              size: 20.0,
                                            ),
                                            onPressed: () {
                                              _showActionSheetForBooks(
                                                  context,
                                                  detailsShelf
                                                      ?.bookList?[index],
                                                  detailsShelf, () {
                                                _removeFromCurrentShelf(
                                                    context,
                                                    detailsShelf
                                                        ?.bookList?[index]);
                                              }, () {
                                                _deleteFromLibrary(
                                                    context,
                                                    detailsShelf
                                                        ?.bookList?[index]);
                                              });
                                            },
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    "No results found!",
                    style: TextStyle(color: LABEL_COLOR, fontSize: 18.0),
                  ),
                );
        });
  }
}

void _showActionSheetForBooks(
    BuildContext context,
    BookVO? book,
    ShelfVO? shelf,
    Function removeFromCurrentShelf,
    Function deleteFromLibrary) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.8,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  InkWell(
                    child: ListTileView(
                      "Delete from your library",
                      Icon(
                        Icons.delete_outline,
                        color: LABEL_COLOR,
                      ),
                    ),
                    onTap: () {
                      deleteFromLibrary();
                    },
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
                      _navigateToAddToShelvesPage(
                          context, book, 1); // 1 for add
                    },
                  ),
                  InkWell(
                    child: ListTileView(
                      "Remove from shelves..",
                      Icon(
                        Icons.delete_outline,
                        color: LABEL_COLOR,
                      ),
                    ),
                    onTap: () {
                      _navigateToAddToShelvesPage(
                          context, book, 2); // 2 for remove
                    },
                  ),
                  InkWell(
                    child: ListTileView(
                      "Remove from \"${shelf?.shelfName}\"",
                      Icon(
                        Icons.delete_outline,
                        color: LABEL_COLOR,
                      ),
                    ),
                    onTap: () {
                      removeFromCurrentShelf();
                    },
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
            ],
          ),
        );
      });
}

_removeFromCurrentShelf(BuildContext context, BookVO? book) {
  ShelfDetailsPageBlocWithProvider bloc =
      Provider.of<ShelfDetailsPageBlocWithProvider>(context, listen: false);
  bloc.removeFromCurrentShelf(book);
  Navigator.pop(context);
  // Navigator.of(context).popUntil((route) => route.isFirst);
}

_deleteFromLibrary(BuildContext context, BookVO? book) {
  // ShelfDetailsPageBlocWithProvider bloc =
  //     Provider.of<ShelfDetailsPageBlocWithProvider>(context, listen: false);
  // bloc.deleteFromLibrary(book);

  // Navigator.pop(context);
}

_navigateToAddToShelvesPage(BuildContext context, BookVO? book, int flag) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddToShelvesPage(book, flag),
    ),
  );
}

class ChooseBooksView extends StatelessWidget {
  final Icon _icon;
  final Function getRadioValue;
  int _radioSelected;
  ChooseBooksView(
    this._icon,
    this.getRadioValue,
    this._radioSelected,
  );

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _icon,
      onPressed: () {
        showModalBottomSheet(
          useRootNavigator: true,
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.8,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 12.0, 0.0, 0.0),
                          child: Text(
                            "View as",
                            style: TextStyle(
                                color: LABEL_COLOR,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          )),
                      Divider(
                        thickness: 1.0,
                        height: 28.0,
                      ),
                      Column(
                        children: [
                          RadioListTile(
                            value: 1,
                            groupValue: _radioSelected,
                            onChanged: (value) {
                              setState(() {
                                _radioSelected = value as int;
                              });
                              getRadioValue(value);
                              _close(context);
                            },
                            title: Text("List"),
                          ),
                          RadioListTile(
                            value: 2,
                            groupValue: _radioSelected,
                            onChanged: (value) {
                              setState(() {
                                _radioSelected = value as int;
                              });
                              getRadioValue(value);
                              _close(context);
                            },
                            title: Text("Large grid"),
                          ),
                          RadioListTile(
                            value: 3,
                            groupValue: _radioSelected,
                            onChanged: (value) {
                              setState(() {
                                _radioSelected = value as int;
                              });
                              getRadioValue(value);
                              _close(context);
                            },
                            title: Text("Small grid"),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

void _close(BuildContext ctx) {
  Navigator.of(ctx).pop();
}

class FilterView extends StatelessWidget {
  final Function removeFilters;
  final Function getSelectedItems;
  FilterView({required this.removeFilters, required this.getSelectedItems});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.0, 18.0, 0, 0),
      child: Container(
        height: 37.0,
        width: double.infinity,
        color: Colors.transparent,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: [
            RemoveFilterButtonView(removeFilters: removeFilters),
            Selector<ShelfDetailsPageBlocWithProvider, bool>(
                selector: (context, bloc) => bloc.showSelectedFilter,
                builder: (BuildContext context, showSelectedFilter, child) {
                  return Visibility(
                    visible: showSelectedFilter,
                    child: SizedBox(
                      width: 10.0,
                    ),
                  );
                }),
            Selector<ShelfDetailsPageBlocWithProvider, bool>(
                selector: (context, bloc) => bloc.showSelectedFilter,
                builder: (BuildContext context, showSelectedFilter, child) {
                  return Visibility(
                      visible: showSelectedFilter,
                      child: SelectedFilterTypesView());
                }),
            Selector<ShelfDetailsPageBlocWithProvider, bool>(
              selector: (context, bloc) => bloc.showSelectedFilter,
              builder: (BuildContext context, showSelectedFilter, child) {
                return Visibility(
                  visible: showSelectedFilter,
                  child: SizedBox(
                    width: 10.0,
                  ),
                );
              },
            ),
            FilterTypesView(
              getSelectedItems: (context, type) {
                getSelectedItems(context, type);
              },
            )
          ],
        ),
      ),
    );
  }
}

class FilterTypesView extends StatelessWidget {
  final Function getSelectedItems;

  FilterTypesView({required this.getSelectedItems});
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      // physics: ClampingScrollPhysics(),
      children: [
        Selector<ShelfDetailsPageBlocWithProvider, bool>(
            selector: (context, bloc) => bloc.showDowloadAndNotDownloaded,
            builder:
                (BuildContext context, showDowloadAndNotDownloaded, child) {
              return GestureDetector(
                child: Visibility(
                  visible: showDowloadAndNotDownloaded,
                  child: Container(
                    width: 100.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          bottomLeft: Radius.circular(18.0),
                        ),
                        border: Border.all(width: 0.15)),
                    child: Center(
                      child: FilterTypeText("Downloaded"),
                    ),
                  ),
                ),
                onTap: () {
                  getSelectedItems(context, "Downloaded");
                },
              );
            }),
        Selector<ShelfDetailsPageBlocWithProvider, bool>(
            selector: (context, bloc) => bloc.showDowloadAndNotDownloaded,
            builder:
                (BuildContext context, showDowloadAndNotDownloaded, child) {
              return GestureDetector(
                child: Visibility(
                  visible: showDowloadAndNotDownloaded,
                  child: Container(
                    width: 110.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18.0),
                        bottomRight: Radius.circular(18.0),
                      ),
                      border: Border.all(width: 0.15),
                    ),
                    child: Center(
                      child: FilterTypeText("Not downloaded"),
                    ),
                  ),
                ),
                onTap: () {
                  getSelectedItems(context, "Not downloaded");
                },
              );
            }),
        SizedBox(
          width: 10.0,
        ),
        Selector<ShelfDetailsPageBlocWithProvider, bool>(
            selector: (context, bloc) => bloc.showNotStartedAndShowInProgess,
            builder:
                (BuildContext context, showNotStartedAndShowInProgess, child) {
              return GestureDetector(
                child: Visibility(
                  visible: showNotStartedAndShowInProgess,
                  child: Container(
                    width: 100.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        bottomLeft: Radius.circular(18.0),
                      ),
                      border: Border.all(width: 0.15),
                    ),
                    child: Center(
                      child: FilterTypeText("Not started"),
                    ),
                  ),
                ),
                onTap: () {
                  getSelectedItems(context, "Not started");
                },
              );
            }),
        Selector<ShelfDetailsPageBlocWithProvider, bool>(
            selector: (context, bloc) => bloc.showNotStartedAndShowInProgess,
            builder:
                (BuildContext context, showNotStartedAndShowInProgess, child) {
              return GestureDetector(
                child: Visibility(
                  visible: showNotStartedAndShowInProgess,
                  child: Container(
                    width: 100.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18.0),
                        bottomRight: Radius.circular(18.0),
                      ),
                      border: Border.all(width: 0.15),
                    ),
                    child: Center(
                      child: FilterTypeText("In progress"),
                    ),
                  ),
                ),
                onTap: () {
                  getSelectedItems(context, "In progress");
                },
              );
            }),
      ],
    );
  }
}

class FilterTypeText extends StatelessWidget {
  final String _text;
  FilterTypeText(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
        color: LABEL_COLOR,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class SelectedFilterTypesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<ShelfDetailsPageBlocWithProvider, List<String>>(
        selector: (context, bloc) => bloc.selectedType, //to check
        shouldRebuild: (previous, next) => true,
        builder: (BuildContext context, selectedType, child) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: selectedType.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: (selectedType.length > 1)
                      ? EdgeInsets.only(right: 10.0)
                      : EdgeInsets.only(right: 0.0),
                  width: 110.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(4, 82, 130, 1.0),
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(width: 0.15),
                  ),
                  child: Center(
                    child: Text(
                      selectedType[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              });
        });
  }
}

class RemoveFilterButtonView extends StatelessWidget {
  final Function removeFilters;
  RemoveFilterButtonView({required this.removeFilters});

  @override
  Widget build(BuildContext context) {
    return Selector<ShelfDetailsPageBlocWithProvider, bool>(
        selector: (context, bloc) => bloc.showSelectedFilter,
        builder: (BuildContext context, showSelectedFilter, child) {
          return GestureDetector(
            child: Visibility(
              visible: showSelectedFilter,
              child: Container(
                width: 32.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(width: 0.3),
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 18.0,
                  ),
                ),
              ),
            ),
            onTap: () {
              removeFilters(context);
            },
          );
        });
  }
}

deleteShelf(BuildContext context, ShelfVO? shelf) {
  ShelfDetailsPageBlocWithProvider bloc =
      Provider.of<ShelfDetailsPageBlocWithProvider>(context, listen: false);
  bloc.deleteShelf(shelf);

  Navigator.of(context).popUntil((route) => route.isFirst);
}

showDiaLogForDeleteShelf(BuildContext context1, ShelfVO? shelf) {
  showDialog(
    context: context1,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Delete ${shelf?.shelfName}"),
        content: new Text(
            "This shelf will be deleted from all of your devices.Purchases,samples,uploads and rentals will stay in \"Your books\""),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DeleteButtonView(
                  "Cancel",
                  Colors.white,
                  APP_THEME_COLOR,
                  (context) {
                    Navigator.pop(context);
                  },
                  isGhostBtn: true,
                ),
                SizedBox(
                  width: 10.0,
                ),
                DeleteButtonView(
                  "Delete",
                  APP_THEME_COLOR,
                  Colors.white,
                  (context) {
                    deleteShelf(context1, shelf);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

class DeleteButtonView extends StatelessWidget {
  final String titleText;
  final Color bgColor;
  final Color textColor;
  final Function deleteShelf;

  final bool isGhostBtn;

  DeleteButtonView(
    this.titleText,
    this.bgColor,
    this.textColor,
    this.deleteShelf, {
    this.isGhostBtn = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 32.0,
        width: 110.0,
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
        child: Center(
          child: Text(
            titleText,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w500, fontSize: 15.0),
          ),
        ),
      ),
      onTap: () {
        deleteShelf(context);
      },
    );
  }
}

clickRename(BuildContext context) {
  ShelfDetailsPageBlocWithProvider bloc =
      Provider.of<ShelfDetailsPageBlocWithProvider>(context, listen: false);
  bloc.clickRename();
  Navigator.pop(context);
}

onChanged(BuildContext context, String value) {
  ShelfDetailsPageBlocWithProvider bloc =
      Provider.of<ShelfDetailsPageBlocWithProvider>(context, listen: false);
  bloc.onChanged(value);
}

_onSubmitted(BuildContext context, ShelfVO? shelf, String? value) {
  ShelfDetailsPageBlocWithProvider bloc =
      Provider.of<ShelfDetailsPageBlocWithProvider>(context, listen: false);
  bloc.checkShelfNameForShelfDetails(
      context, ShelfVO(shelf?.id ?? "", value, shelf?.bookList));
}
