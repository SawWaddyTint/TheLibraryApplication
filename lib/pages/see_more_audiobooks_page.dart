import 'package:TheLibraryApplication/resources/colors.dart';
import 'package:TheLibraryApplication/view_items/book_view.dart';
import 'package:flutter/material.dart';

class SeeMoreAudiobooksPage extends StatelessWidget {
  // const SeeMoreBooksPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
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
          "More Like Standing Tall: The Goh Chok",
          style: TextStyle(
            color: TITLE_COLOR,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.42),
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: BookView(
                150,
                100,
                () {},
                showHeadset: true,
              ),
              onTap: () {
                // _navigateToBookDetailPage(context);
              },
            );
          },
        ),
      ),
    );
  }
}

// _navigateToBookDetailPage(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => BookDetailsPage(
//         90,
//         90,
//         "Play Sample",
//         showBtnIcon: true,
//       ),
//     ),
//   );
// }
