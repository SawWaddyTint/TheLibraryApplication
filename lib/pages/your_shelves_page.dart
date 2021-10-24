import 'package:TheLibraryApplication/bloc/shelf_bloc_with_provider.dart';
import 'package:TheLibraryApplication/bloc/your_shelves_page_bloc_with_provider.dart';

import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/pages/create_shelf.dart';
import 'package:TheLibraryApplication/resources/colors.dart';
import 'package:TheLibraryApplication/pages/shelf_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// List<String> createdShelves

class YourShelvesPage extends StatelessWidget {
  // const YourShelvesPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => YourShelvesPageBlocWithProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Selector<YourShelvesPageBlocWithProvider, bool>(
                  selector: (context, bloc) => bloc.showList,
                  builder: (BuildContext context, showList, child) {
                    return ShelvesListView(
                      showList,
                    );
                  },
                ),
                Selector<YourShelvesPageBlocWithProvider, bool>(
                    selector: (context, bloc) => bloc.showList,
                    builder: (BuildContext context, showList, child) {
                      return NoShelvesMessageView(showList);
                    }),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
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
      ),
    );
  }
}

class NoShelvesMessageView extends StatelessWidget {
  final bool showList;
  NoShelvesMessageView(this.showList);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 250.0),
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
                child: Text("Create shelves to match the way you think"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShelvesListView extends StatelessWidget {
  ShelvesListView(this.showList);
  final bool showList;
  // final Function navigateToShelfDetailsPage;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 0),
        child: Column(
          children: [
            Visibility(
              visible: showList,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 14.0,
                ),
                child: Selector<YourShelvesPageBlocWithProvider,
                        List<ShelfVO>?>(
                    selector: (context, bloc) => bloc.allCreatedShelves,
                    shouldRebuild: (previous, next) => true,
                    builder: (BuildContext context, allCreatedShelves, child) {
                      return ListView.builder(
                        itemCount: allCreatedShelves?.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 65,
                                      width: 65,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        child: Image.network(
                                          ((allCreatedShelves?[index]
                                                      .bookList
                                                      ?.isNotEmpty ??
                                                  false))
                                              ? "${allCreatedShelves?[index].bookList?[(allCreatedShelves[index].bookList?.length ?? 0) - 1].bookImage}"
                                              : "https://htmlcolorcodes.com/assets/images/colors/light-gray-color-solid-background-1920x1080.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            allCreatedShelves?[index]
                                                    .shelfName ??
                                                "",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: (allCreatedShelves?[index]
                                                            .bookList
                                                            ?.length ==
                                                        0 ||
                                                    allCreatedShelves?[index]
                                                            .bookList
                                                            ?.length ==
                                                        1)
                                                ? Text(
                                                    "${allCreatedShelves?[index].bookList?.length} book",
                                                    style: TextStyle(
                                                      color: LABEL_COLOR,
                                                    ),
                                                  )
                                                : Text(
                                                    "${allCreatedShelves?[index].bookList?.length} books",
                                                    style: TextStyle(
                                                      color: LABEL_COLOR,
                                                    ),
                                                  ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: LABEL_COLOR,
                                          size: 18.0,
                                        ),
                                        onPressed: null)
                                  ],
                                ),
                                onTap: () {
                                  _navigateToShelfDetailsPage(
                                      context, allCreatedShelves?[index]);
                                },
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
                      );
                    }),
              ),
            ),
          ],
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

_navigateToShelfDetailsPage(context, ShelfVO? shelf) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ShelfDetailsPage(shelf),
    ),
  );
}
