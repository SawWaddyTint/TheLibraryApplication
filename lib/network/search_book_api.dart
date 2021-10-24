import 'package:TheLibraryApplication/network/api_constants.dart';
import 'package:TheLibraryApplication/network/responses/book_overview_response.dart';
import 'package:TheLibraryApplication/network/responses/books_by_list_name_response.dart';
import 'package:TheLibraryApplication/network/responses/search_books_resoponse.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'search_book_api.g.dart';

@RestApi(baseUrl: BASE_URL_SEARCH_BOOK_DIO)
abstract class SearchBookApi {
  factory SearchBookApi(Dio dio) = _SearchBookApi;
  @GET(END_POINT_VOLUMES)
  Future<SearchBookResponse> getSearchBooks(
    @Query(PARAM_Q) String q,
  );
}
