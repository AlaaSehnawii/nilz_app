import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/shared/shared_pref.dart';
import 'api_url.dart';

class ApiMethods {
  final bool? isSecondBaseUrl;
  final Map<String, String>? extraHeaders;

  ApiMethods({this.isSecondBaseUrl, Map<String, String>? header})
    : extraHeaders = header;

  Map<String, String> _baseHeaders() => <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Parse-Javascript-Key': 'OxmP73vb9H3St83gzr4guLQzm',
    'X-Parse-Application-Id': 'bM9f39TlvXy3S52z56kDIlzMO',
  };

  Map<String, String> _buildHeaders() {
    final token = AppSharedPreferences.getToken();
    final headers = <String, String>{..._baseHeaders()};
    if (token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    if (extraHeaders != null && extraHeaders!.isNotEmpty) {
      headers.addAll(extraHeaders!);
    }

    return headers;
  }

  Map<String, dynamic> filterRequest(Map<String, dynamic> inputMap) {
    final filteredMap = inputMap
      ..removeWhere(
        (key, value) =>
            value == null ||
            value == DateTime(0) ||
            value == '' ||
            value == -1 ||
            value == {} ||
            value == '{}' ||
            (value is Map && value.isEmpty) ||
            value == '0000-01-01' ||
            value == [] ||
            value == '0000-01-0',
      );

    filteredMap.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        filteredMap[key] = filterRequest(value);
      }
    });
    return filteredMap;
  }

  Uri _buildUri({
    required String url,
    Map<String, dynamic>? path,
    Map<String, dynamic>? query,
  }) {
    final api = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl);
    var builder = api;
    if (path != null && path.isNotEmpty) builder = builder.getPath(path);
    if (query != null && query.isNotEmpty) builder = builder.getQuery(query);
    return builder.getLink();
  }

  Future<http.Response> get({
    required String url,
    Map<String, dynamic>? path,
    Map<String, dynamic>? query,
  }) async {
    if (query != null) query = filterRequest(query);
    if (path != null) path = filterRequest(path);

    final uri = _buildUri(url: url, path: path, query: query);
    final headers = _buildHeaders();
    final res = await http.get(uri, headers: headers);

    return res;
  }

  Future<http.Response> postNoHeaders({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    if (query != null) query = filterRequest(query);
    if (body != null) body = filterRequest(body);

    final Map<String, String> noHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final uri = _buildUri(url: url, query: query);
    return http.post(uri, body: jsonEncode(body), headers: noHeaders);
  }

  Future<http.Response> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    final filteredQuery = query == null ? null : filterRequest({...query});
    final filteredBody = body == null ? null : filterRequest({...body});

    final uri = _buildUri(url: url, query: filteredQuery);
    final headers = _buildHeaders();

    String? encodedBody;
    final hasBody = filteredBody != null && filteredBody.isNotEmpty;
    if (hasBody) {
      headers['Content-Type'] = 'application/json';
      encodedBody = jsonEncode(filteredBody);
    }

    return http.post(uri, headers: headers, body: hasBody ? encodedBody : null);
  }

  Future<http.Response> patch({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    final filteredQuery = query == null ? null : filterRequest({...query});
    final filteredBody = body == null ? null : filterRequest({...body});

    final uri = _buildUri(url: url, query: filteredQuery);
    final headers = _buildHeaders();

    String? encodedBody;
    final hasBody = filteredBody != null && filteredBody.isNotEmpty;
    if (hasBody) {
      headers['Content-Type'] = 'application/json';
      encodedBody = jsonEncode(filteredBody);
    }

    return http.patch(
      uri,
      headers: headers,
      body: hasBody ? encodedBody : null,
    );
  }

  Future<http.Response> put({
    required String url,
    required Map<String, dynamic> query,
    dynamic body,
  }) async {
    query = filterRequest(query);
    final uri = _buildUri(url: url, query: query);
    final headers = _buildHeaders();
    return http.put(uri, body: jsonEncode(body), headers: headers);
  }

  Future<http.Response> delete({
    required String url,
    Map<String, dynamic>? path,
    Map<String, dynamic>? body,
  }) async {
    final uri = _buildUri(url: url, path: path);
    final headers = _buildHeaders();
    if (body == null) {
      headers.removeWhere((k, v) => k.toLowerCase() == "content-type");

      return http.delete(uri, headers: headers);
    } else {
      headers["content-type"] = "application/json";
      return http.delete(uri, headers: headers, body: jsonEncode(body));
    }
  }
}
