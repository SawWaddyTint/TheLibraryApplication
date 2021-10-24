// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _BookApi implements BookApi {
  _BookApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.nytimes.com/svc/books/v3';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BookOverviewResponse> getBookOverviewList(
      apiKey, publishedDate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api-key': apiKey,
      r'published_date': publishedDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookOverviewResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/lists/overview.json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BookOverviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BooksByListNameResponse> getBooksByListName(date, list, apiKey) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'api-key': apiKey};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BooksByListNameResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/lists/$date/$list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BooksByListNameResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
