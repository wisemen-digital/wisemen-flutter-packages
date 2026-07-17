import 'package:http/http.dart' as http;

/// A decoded JSON object, as returned by `jsonDecode` and the Linear API.
typedef Json = Map<String, dynamic>;

/// HTTP status helpers shared by the transports.
extension HttpResponseStatus on http.BaseResponse {
  /// Whether the status code is in the 2xx success range.
  bool get isSuccessful => statusCode >= 200 && statusCode < 300;
}
