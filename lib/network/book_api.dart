import 'package:TheLibraryApplication/network/api_constants.dart';
import 'package:TheLibraryApplication/network/responses/book_overview_response.dart';
import 'package:TheLibraryApplication/network/responses/books_by_list_name_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'book_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class BookApi {
  factory BookApi(Dio dio) = _BookApi;
  @GET(END_POINT_BOOK_OVERVIEW)
  Future<BookOverviewResponse> getBookOverviewList(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_PUBLISHED_DATE) String publishedDate,
  );

  @GET("$END_POINT_BOOK_BY_LIST_NAME/{date}/{list}")
  Future<BooksByListNameResponse> getBooksByListName(
    @Path("date") String date,
    @Path("list") String list,
    @Query(PARAM_API_KEY) String apiKey,
  );
}
