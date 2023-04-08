import 'dart:async' show FutureOr;
import 'dart:convert' show json, utf8;
import 'dart:io' show SocketException;
import 'package:http/http.dart' as http;

typedef Json = Map<String, dynamic>;

class APIService {
  final String _baseUrl = "";

  String _path(String path){
    String _path = path.trim();
    if (!_path.startsWith("/")) _path = "/" + _path;
    return _path;
  }

  Map<String, String> _headers({required String? accessToken}) => {"content-type":"application/json", "authorization": "Bearer $accessToken"};

  Future<void> postToServer({
    required String path,
    Map<String, String>? headers,
    required String? accessToken,
    required dynamic body,
    FutureOr<void> Function(String)? errorCb,
    FutureOr<void> Function(String)? successCb,
  }) async {
    try {
      final http.Response _res = await http.post(
        Uri.parse(this._baseUrl + this._path(path)),
        headers: {...headers ?? {}, ...this._headers(accessToken: accessToken)},
        body: json.encode(body),
      ).timeout(const Duration(seconds: 13), onTimeout: () => http.Response("null", 404));

      final Json _decodedBody = json.decode(utf8.decode(_res.bodyBytes)) as Json;
      if (_decodedBody.containsKey("error") && errorCb != null) await errorCb(_decodedBody["error"]);
      if (_decodedBody.containsKey("success") && successCb != null) await successCb(_decodedBody["success"]);
    } catch (e) {
      print(e);
      if (e.runtimeType == SocketException && errorCb != null) await errorCb("Cannot connect to the server.");
    }
  }
}