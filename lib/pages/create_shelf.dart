import 'dart:ui';

import 'package:TheLibraryApplication/bloc/shelf_bloc_with_provider.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/resources/colors.dart';

import 'package:TheLibraryApplication/pages/your_shelves_page.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CreateShelfPage extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  bool hasSameName = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ShelfBlocWithProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: AppBarButtonsView(textController),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreateShelfTextFieldView(textController),
              CreatedShelfView(),
              Divider(
                thickness: 1.0,
              ),
              // Spacer(),
              NoBooksMessageView(),
            ],
          ),
        ),
      ),
    );
  }
}

class NoBooksMessageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<ShelfBlocWithProvider, bool>(
        selector: (context, bloc) => bloc.showCreatedShelf,
        builder: (BuildContext context, showCreatedShelf, child) {
          return Visibility(
            visible: showCreatedShelf,
            child: Padding(
              padding: EdgeInsets.fromLTRB(70.0, 100.0, 0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "lib/assets/no_shelves.png",
                    height: 120.0,
                    width: 120.0,
                  ),
                  Text(
                    "No books on this shelf",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Add some books in your library from the \nbook's ---menu",
                      style: TextStyle(
                        color: LABEL_COLOR,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class CreatedShelfView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<ShelfBlocWithProvider, bool>(
        selector: (context, bloc) => bloc.showCreatedShelf,
        builder: (BuildContext context, showCreatedShelf, child) {
          return Visibility(
            visible: showCreatedShelf,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Selector<ShelfBlocWithProvider, List<ShelfVO>?>(
                  selector: (context, bloc) => bloc.shelfList,
                  builder: (BuildContext context, shelfList, child) {
                    return (shelfList != null)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (shelfList.length > 0)
                                  ? Text(
                                      shelfList[shelfList.length - 1]
                                              .shelfName ??
                                          "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "0 books",
                                  style: TextStyle(
                                    color: LABEL_COLOR,
                                    fontSize: 16.0,
                                  ),
                                ),
                              )
                            ],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  }),
            ),
          );
        });
  }
}

class CreateShelfTextFieldView extends StatelessWidget {
  CreateShelfTextFieldView(this.textController);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Selector<ShelfBlocWithProvider, bool>(
        selector: (context, bloc) => bloc.showCreatedShelf,
        builder: (BuildContext context, showCreatedShelf, child) {
          return Visibility(
            visible: !showCreatedShelf,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: textController,
                autofocus: true,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: "Shelf name",
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
                      ShelfBlocWithProvider bloc =
                          Provider.of<ShelfBlocWithProvider>(context,
                              listen: false);
                      bloc.onChanged("");
                      textController.clear();
                    },
                  ),
                ),
                onChanged: (value) => onChanged(context, value),
                onSubmitted: (value) => _onSubmitted(context, value),
                maxLength: 50,
              ),
            ),
          );
        });
  }
}

class AppBarButtonsView extends StatelessWidget {
  AppBarButtonsView(this.textController);

  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return Selector<ShelfBlocWithProvider, bool>(
        selector: (context, bloc) => bloc.hasValue,
        builder: (BuildContext context, hasValue, child) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (hasValue)
                    ? CreateShelfButton(textController: textController)
                    : InkWell(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: LABEL_COLOR,
                          size: 20.0,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                SizedBox(
                  width: 100.0,
                ),
                Text(
                  "Create shelf",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class CreateShelfButton extends StatelessWidget {
  const CreateShelfButton({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          ShelfBlocWithProvider bloc =
              Provider.of<ShelfBlocWithProvider>(context,
                  listen: false);
          bloc.checkShelfName(
              context, ShelfVO("", textController?.text, []));
        },
      );
  }
}

// void _showAlertDiaLog(BuildContext context) {
//   // set up the button
//   Widget okButton = TextButton(
//     child: Text("OK"),
//     onPressed: () {},
//   );

//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text("Unable to create shelf"),
//     content: Text(
//         "The shelf name you have chosen already exists.Please try another name"),
//     actions: [
//       okButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

onChanged(BuildContext context, String value) {
  ShelfBlocWithProvider bloc =
      Provider.of<ShelfBlocWithProvider>(context, listen: false);
  bloc.onChanged(value);
}

_onSubmitted(BuildContext context, String value) {
  ShelfBlocWithProvider bloc =
      Provider.of<ShelfBlocWithProvider>(context, listen: false);
  bloc.checkShelfName(context, ShelfVO("", value, []));
}
