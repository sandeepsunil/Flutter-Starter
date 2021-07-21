class HTTPResponse {
  int status;
  Map<String, String> headers;
  var body;

  HTTPResponse({
    required this.status,
    required this.body,
    required this.headers,
  });
}
