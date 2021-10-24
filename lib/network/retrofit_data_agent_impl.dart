import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/books_by_list_name_vo.dart';
import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';
import 'package:TheLibraryApplication/network/book_api.dart';
import 'package:TheLibraryApplication/network/book_data_agent.dart';
import 'package:TheLibraryApplication/network/search_book_api.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'api_constants.dart';

class RetrofitDataAgentImpl extends BookDataAgent {
  BookApi? bApi;
  SearchBookApi? sbApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();

    bApi = BookApi(dio);
    sbApi = SearchBookApi(dio);
  }
  String publishedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // String searchText = "flutter";

  @override
  Future<List<BookListVO>?>? getBookOverviewList() {
    return bApi
        ?.getBookOverviewList(API_KEY, publishedDate)
        .asStream()
        .map((response) => response.results?.lists)
        .first;
  }

  @override
  Future<List<BookVO>?>? getBooksByListName(String listName) {
    return bApi
        ?.getBooksByListName(publishedDate, listName, API_KEY)
        .asStream()
        .map((response) => response.results?.books)
        .first;
  }

  @override
  Future<List<SearchBookVO>?>? getSearchBooksList(String searchText) {
    return sbApi
        ?.getSearchBooks(searchText)
        .asStream()
        .map((response) => response.items)
        .first;
  }
}
