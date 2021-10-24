import 'package:TheLibraryApplication/bloc/add_to_shelves_page_bloc_with_provider.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/pages/create_shelf.dart';
import 'package:TheLibraryApplication/pages/home_page.dart';
import 'package:TheLibraryApplication/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToShelvesPage extends StatelessWidget {
  final BookVO? book;
  final int flag;
  AddToShelvesPage(this.book, this.flag);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          AddToShelvesPageBlocWithProvider(book: book),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          flag == 1 ? "Add to shelves" : "Remove from shelves",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 4.0, 20.0, 0.0),
                            child: Text(
                              "DONE",
                              style: TextStyle(
                                  color: APP_THEME_COLOR,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Selector<AddToShelvesPageBlocWithProvider, List<ShelfVO>?>(
                  selector: (context, bloc) => bloc.allCreatedShelves,
                  shouldRebuild: (previous, next) => true,
                  builder: (BuildContext context, allCreatedShelves, child) {
                    return (allCreatedShelves != null)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: [
                                ListView.builder(
                                  itemCount: allCreatedShelves.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  // itemExtent: 100,
                                  // scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 65,
                                                width: 65,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  child: Image.network(
                                                    ((allCreatedShelves[index]
                                                                .bookList
                                                                ?.isNotEmpty ??
                                                            false))
                                                        ? "${allCreatedShelves[index].bookList?[(allCreatedShelves[index].bookList?.length ?? 0) - 1].bookImage}"
                                                        : "https://htmlcolorcodes.com/assets/images/colors/light-gray-color-solid-background-1920x1080.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      allCreatedShelves[index]
                                                              .shelfName ??
                                                          "",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: (allCreatedShelves[
                                                                          index]
                                                                      .bookList
                                                                      ?.length ==
                                                                  0 ||
                                                              allCreatedShelves[
                                                                          index]
                                                                      .bookList
                                                                      ?.length ==
                                                                  1)
                                                          ? Text(
                                                              "${allCreatedShelves[index].bookList?.length} book",
                                                              style: TextStyle(
                                                                color:
                                                                    LABEL_COLOR,
                                                              ),
                                                            )
                                                          : Text(
                                                              "${allCreatedShelves[index].bookList?.length} books",
                                                              style: TextStyle(
                                                                color:
                                                                    LABEL_COLOR,
                                                              ),
                                                            ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Checkbox(
                                                value: allCreatedShelves[index]
                                                    .isChecked,
                                                onChanged: (value) {
                                                  AddToShelvesPageBlocWithProvider
                                                      bloc = Provider.of<
                                                              AddToShelvesPageBlocWithProvider>(
                                                          context,
                                                          listen: false);
                                                  bloc.selectShelves(
                                                      allCreatedShelves[index]);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1.0,
                                          height: 0.0,
                                        ),
                                        SizedBox(
                                          height: 14.0,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
                Selector<AddToShelvesPageBlocWithProvider, bool>(
                  selector: (context, bloc) => bloc.showList,
                  shouldRebuild: (previous, next) => true,
                  builder: (BuildContext context, showList, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 120.0),
                      child: Visibility(
                        visible: !showList,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "lib/assets/no_shelves.png",
                              height: 120.0,
                              width: 120.0,
                            ),
                            Text(
                              "No Shelves",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                  "Create shelves to match the way you think"),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              Selector<AddToShelvesPageBlocWithProvider, bool>(
                  selector: (context, bloc) => bloc.showList,
                  shouldRebuild: (previous, next) => true,
                  builder: (BuildContext context, showList, child) {
                    return Visibility(
                      visible: !showList,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: new FloatingActionButton.extended(
                          backgroundColor: APP_THEME_COLOR,
                          onPressed: () {
                            _navigateToCreateShelvesPage(context);
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 18.0,
                          ),
                          label: Text("Create new"),
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}

_navigateToCreateShelvesPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateShelfPage(),
    ),
  );
}
