import 'package:TheLibraryApplication/bloc/your_books_page_bloc_with_provider.dart';

import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/pages/add_to_shelves_page.dart';
import 'package:TheLibraryApplication/resources/colors.dart';

import 'package:TheLibraryApplication/view_items/book_view.dart';
import 'package:TheLibraryApplication/view_items/list_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourBooksPage extends StatelessWidget {
  int _radioSelected = 1;
  int _sortedRadioSelected = 1;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => YourBooksPageBlocWithProvider(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FilterView(
              getSelectedItems: (context, type) =>
                  getSelectedItems(context, type),
              removeFilters: (context) => removeFilters(context),
            ),
            Selector<YourBooksPageBlocWithProvider, bool>(
                selector: (context, bloc) => bloc.showSelectedFilter,
                builder: (BuildContext context, showSelectedFilter, child) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 14.0, 0.0, 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 9.0),
                          child: Row(
                            children: [
                              SortedByView(
                                  (value) =>
                                      getSortedByRadioValue(context, value),
                                  _sortedRadioSelected),
                              Spacer(),
                              Selector<YourBooksPageBlocWithProvider, int>(
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
                                          ), (value) {
                                    getRadioValue(context, value);
                                        }, 1,key: Key("List View"),)
                                      : (layoutIndexForBooks == 2)
                                          ? ChooseBooksView(
                                              Icon(
                                                Icons.list_alt,
                                                size: 19.0,
                                                color: LABEL_COLOR,
                                              ), (value) =>
                                      getRadioValue(context, value),2,key: Key("Large Grid View"),)
                                          : ChooseBooksView(
                                              Icon(
                                                Icons.list_alt,
                                                size: 19.0,
                                                color: LABEL_COLOR,
                                              ), (value) {
                                    getRadioValue(
                                                  context, value,);
                                            },3, key: Key("Small Grid View"));
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
            Selector<YourBooksPageBlocWithProvider, int>(
              selector: (context, bloc) => bloc.layoutIndexForBooks,
              builder: (BuildContext context, layoutIndexForBooks, child) {
                return (layoutIndexForBooks == 1)
                    ? BooksListView()
                    : (layoutIndexForBooks == 2)
                        ? BooksLargeGridView()
                        : BooksSmallGridView();
              },
            ),
          ],
        ),
      ),
    );
  }
}

getSortedByRadioValue(BuildContext context, int value) {
  debugPrint("Choosen Sorted By value is  " + value.toString());
  YourBooksPageBlocWithProvider bloc =
      Provider.of<YourBooksPageBlocWithProvider>(context, listen: false);
  bloc.sortedBySelectedIndex(value);
}

void getSelectedItems(BuildContext context, String selected) {
  YourBooksPageBlocWithProvider bloc =
      Provider.of<YourBooksPageBlocWithProvider>(context, listen: false);
  bloc.getSelectedItems(selected);
}

void getRadioValue(BuildContext context, int radioIndex) {
  YourBooksPageBlocWithProvider bloc =
      Provider.of<YourBooksPageBlocWithProvider>(context, listen: false);
  bloc.changeLayoutStyle(radioIndex);
}

removeFilters(BuildContext context) {
  YourBooksPageBlocWithProvider bloc =
      Provider.of<YourBooksPageBlocWithProvider>(context, listen: false);
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
          // SortedByView(
          //   (value) => getSortedByRadioValue(value),
          // ),
          SizedBox(
            width: 10.0,
          ),
          Selector<YourBooksPageBlocWithProvider, String>(
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
              }),
        ],
      ),
      onTap: () {
        showModalBottomSheet(
          useRootNavigator: true,
          context: context,
          builder: (BuildContext context) {
            return ChangeNotifierProvider(
              create: (BuildContext context) => YourBooksPageBlocWithProvider(),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return ChangeNotifierProvider(
                    create: (BuildContext context) =>
                        YourBooksPageBlocWithProvider(),
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
  @override
  Widget build(BuildContext context) {
    return Selector<YourBooksPageBlocWithProvider, List<BookVO>?>(
        selector: (context, bloc) => bloc.readBooks,
        shouldRebuild: (previous, next) => true,
        builder: (BuildContext context, readBooks, child) {
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
                itemCount: readBooks?.length,
                itemBuilder: (context, index) {
                  return BookView(
                    150,
                    100,
                    () {
                      showActionSheetForBookList(context, readBooks?[index]);
                    },
                    showSample: true,
                    showDownload: true,
                    book: readBooks?[index],
                  );
                },
              ),
            ),
          );
        });
  }
}

class BooksLargeGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<YourBooksPageBlocWithProvider, List<BookVO>?>(
        selector: (context, bloc) => bloc.readBooks,
        shouldRebuild: (previous, next) => true,
        builder: (BuildContext context, readBooks, child) {
          return Container(
            height: MediaQuery.of(context).size.height,
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
                itemCount: readBooks?.length,
                itemBuilder: (context, index) {
                  return BookView(
                    230,
                    100,
                    () {
                      showActionSheetForBookList(context, readBooks?[index]);
                    },
                    showDownload: true,
                    showSample: true,
                    book: readBooks?[index],
                  );
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
    return Selector<YourBooksPageBlocWithProvider, List<BookVO>?>(
        selector: (context, bloc) => bloc.readBooks,
        shouldRebuild: (previous, next) => true,
        builder: (BuildContext context, readBooks, child) {
          return (readBooks != null &&
                  readBooks != [] &&
                  (readBooks.isNotEmpty))
              ? ListView.builder(
                  itemCount: readBooks.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 75,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Image.network(
                                    readBooks[index].bookImage ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                width: 170.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        readBooks[index].title ?? "",
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
                                          "${readBooks[index].author} \nEbook . Sample",
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
                                      onPressed: () {
                                        // navigateToShelfDetailsPage(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color: LABEL_COLOR,
                                        size: 20.0,
                                      ),
                                      onPressed: () {
                                        showActionSheetForBookList(
                                            context, readBooks[index]);
                                      },
                                    ),
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

void showActionSheetForBookList(BuildContext context, BookVO? book) {
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
   ChooseBooksView(this._icon, this.getRadioValue,this._radioSelected,{
    Key? key,

  }) : super(key: key);


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
                              _close(context);
                              getRadioValue(value);

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
                              _close(context);
                              getRadioValue(value);

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
                              _close(context);
                              getRadioValue(value);

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
            Selector<YourBooksPageBlocWithProvider, bool>(
                selector: (context, bloc) => bloc.showSelectedFilter,
                builder: (BuildContext context, showSelectedFilter, child) {
                  return Visibility(
                    visible: showSelectedFilter,
                    child: SizedBox(
                      width: 10.0,
                    ),
                  );
                }),
            Selector<YourBooksPageBlocWithProvider, bool>(
                selector: (context, bloc) => bloc.showSelectedFilter,
                builder: (BuildContext context, showSelectedFilter, child) {
                  return Visibility(
                      visible: showSelectedFilter,
                      child: SelectedFilterTypesView());
                }),
            Selector<YourBooksPageBlocWithProvider, bool>(
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
        Selector<YourBooksPageBlocWithProvider, bool>(
            selector: (context, bloc) => bloc.showDowloadAndNotDownloaded,
            builder:
                (BuildContext context, showDowloadAndNotDownloaded, child) {
              return GestureDetector(
                child: Visibility(
                  visible: showDowloadAndNotDownloaded,
                  child: Container(
                    width: 100.0,
                    height: 10.0,
                    // height: 32.0,
                    decoration: BoxDecoration(
                        // color: Color.fromRGBO(4, 82, 130, 1.0),
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
        Selector<YourBooksPageBlocWithProvider, bool>(
            selector: (context, bloc) => bloc.showDowloadAndNotDownloaded,
            builder:
                (BuildContext context, showDowloadAndNotDownloaded, child) {
              return GestureDetector(
                child: Visibility(
                  visible: showDowloadAndNotDownloaded,
                  child: Container(
                    width: 110.0,
                    height: 10.0,
                    // height: 32.0,
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(4, 82, 130, 1.0),
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
        Selector<YourBooksPageBlocWithProvider, bool>(
            selector: (context, bloc) => bloc.showNotStartedAndShowInProgess,
            builder:
                (BuildContext context, showNotStartedAndShowInProgess, child) {
              return GestureDetector(
                child: Visibility(
                  visible: showNotStartedAndShowInProgess,
                  child: Container(
                    width: 100.0,
                    height: 10.0,
                    // height: 32.0,
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(4, 82, 130, 1.0),
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
        Selector<YourBooksPageBlocWithProvider, bool>(
            selector: (context, bloc) => bloc.showNotStartedAndShowInProgess,
            builder:
                (BuildContext context, showNotStartedAndShowInProgess, child) {
              return GestureDetector(
                child: Visibility(
                  visible: showNotStartedAndShowInProgess,
                  child: Container(
                    width: 100.0,
                    height: 10.0,
                    // height: 32.0,
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(4, 82, 130, 1.0),
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
    return Selector<YourBooksPageBlocWithProvider, List<String>?>(
        selector: (context, bloc) => bloc.selectedType, //to check
        shouldRebuild: (previous, next) => true,
        builder: (BuildContext context, selectedType, child) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: selectedType?.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: ((selectedType?.length ?? 0) > 1)
                      ? EdgeInsets.only(right: 10.0)
                      : EdgeInsets.only(right: 0.0),
                  width: 110.0,
                  height: 10.0,
                  // height: 32.0,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(4, 82, 130, 1.0),
                    // color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(width: 0.15),
                  ),
                  child: Center(
                    child: Text(
                      selectedType?[index] ?? "",
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
    return Selector<YourBooksPageBlocWithProvider, bool>(
        selector: (context, bloc) => bloc.showSelectedFilter,
        builder: (BuildContext context, showSelectedFilter, child) {
          return GestureDetector(
            child: Visibility(
              visible: showSelectedFilter,
              child: Container(
                // height: 32.0,
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
