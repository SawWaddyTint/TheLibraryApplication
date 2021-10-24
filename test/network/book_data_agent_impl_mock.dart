import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/network/book_data_agent.dart';

import '../mock_data/mock_data.dart';

class BookDataAgentImplMock extends BookDataAgent {
  @override
  Future<List<BookListVO>?>? getBookOverviewList() {
    return Future.value(getMockBookOverviewList());
  }

  @override
  Future<List<BookVO>?>? getBooksByListName(String listName) {
    return Future.value(getMockBooksByListName());
  }

  @override
  Future<List<SearchBookVO>?>? getSearchBooksList(String searchText) {
    return Future.value(getMockSearchBooksList());
  }
}
