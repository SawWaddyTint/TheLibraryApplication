// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_book_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SearchBookApi implements SearchBookApi {
  _SearchBookApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://www.googleapis.com/books/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SearchBookResponse> getSearchBooks(q) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': q};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchBookResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/volumes',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchBookResponse.fromJson(_result.data!);
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
