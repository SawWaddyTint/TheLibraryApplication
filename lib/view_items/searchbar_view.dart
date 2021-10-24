import 'package:TheLibraryApplication/pages/search_books_page.dart';
import 'package:TheLibraryApplication/resources/colors.dart';

import 'package:flutter/material.dart';

class SearchBarView extends StatelessWidget {
  final double _padding;
  final Function onTap;
  SearchBarView(this._padding, this.onTap);

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(18.0),
    //   child: GestureDetector(
    //     child: AppBar(
    //       toolbarHeight: 50.0,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(10.0),
    //         ),
    //       ),
    //       backgroundColor: Colors.white,
    //       leading: IconButton(
    //         onPressed: () => Navigator.of(context).push(
    //           MaterialPageRoute(
    //             builder: (_) => SearchBooksPage(),
    //           ),
    //         ),
    //         icon: Icon(Icons.search,
    //             color: Colors.black), //   leading: IconButton(
    //       ),
    //       primary: false,
    //       // title: TextField(
    //       //     decoration: InputDecoration(
    //       //         hintText: "Search",
    //       //         border: InputBorder.none,
    //       //         hintStyle: TextStyle(color: Colors.grey))),
    //       actions: <Widget>[
    //         Padding(
    //           padding: EdgeInsets.only(right: 8.0),
    //           child: CircleAvatar(
    //             radius: 15.0,
    //             // backgroundImage: NetworkImage("$IMAGE_BASE_URL${cast.profilePath}"),
    //             backgroundColor: Colors.red,
    //           ),
    //         ),
    //       ],
    //       title: Text(
    //         "Search Play Books",
    //         style: TextStyle(color: LABEL_COLOR, fontSize: 16.0),
    //       ),
    //     ),
    //     onTap: () {
    //       Navigator.of(context).push(
    //         MaterialPageRoute(
    //           builder: (_) => SearchBooksPage(),
    //         ),
    //       );
    //     },
    //   ),
    // );

    // return SliverPadding(
    //   padding: EdgeInsets.all(10.0),
    //   sliver: SliverAppBar(
    //     pinned: true,
    //     floating: true,
    //     shadowColor: Colors.white,
    //     backgroundColor: Colors.white,
    //     automaticallyImplyLeading: false,
    //     // toolbarHeight: 40.0,
    //     expandedHeight: 50.0,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(10.0),
    //       ),
    //     ),
    //     leading: IconButton(
    //       onPressed: () => Navigator.of(context).push(
    //         MaterialPageRoute(
    //           builder: (_) => SearchBooksPage(),
    //         ),
    //       ),
    //       icon:
    //           Icon(Icons.search, color: Colors.black), //   leading: IconButton(
    //     ),
    //     actions: <Widget>[
    //       Padding(
    //         padding: EdgeInsets.only(right: 8.0),
    //         child: CircleAvatar(
    //           radius: 12.0,
    //           // backgroundImage: NetworkImage("$IMAGE_BASE_URL${cast.profilePath}"),
    //           backgroundColor: Colors.red,
    //         ),
    //       ),
    //     ],
    //   ),
    //   // onTap: () {
    //   //   Navigator.of(context).push(
    //   //     MaterialPageRoute(
    //   //       builder: (_) => SearchBooksPage(),
    //   //     ),
    //   //   );
    //   // },
    //   // flexibleSpace: Container(
    //   //   height: 50.0,
    //   // ),
    // );

    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(_padding),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(8.0),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     // spreadRadius: 5,
                  //     // blurRadius: 7,
                  //     // offset: Offset(0, 3), // changes position of shadow
                  //   ),
                  // ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SearchBooksPage(),
                  ),
                ),
                icon: Icon(Icons.search,
                    color: Colors.black), //   leading: IconButton(
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 100.0, 0.0),
                child: Text(
                  "Search Play Books",
                  style: TextStyle(color: LABEL_COLOR, fontSize: 15.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 14.0,
                  // backgroundImage: NetworkImage("$IMAGE_BASE_URL${cast.profilePath}"),
                  backgroundColor: Colors.pink,
                  child: Text(
                    "S",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
