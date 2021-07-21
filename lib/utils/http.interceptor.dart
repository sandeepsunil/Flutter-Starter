import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_starter/utils/http_response.dart';
import 'package:flutter_starter/utils/utilities.dart';
import 'package:http/http.dart' as http;

class HttpInterceptor {
  HttpInterceptor() {
    print("${this.runtimeType} Constructed");
  }
  String _baseUri = "http://192.168.1.6:8000";
  http.Client client = http.Client();

  String get baseUrl => _baseUri;

  Future<HTTPResponse?> restCall(
    String endpoint, {
    required Request request,
    Map? body,
    bool useBaseUri = true,
    Map<String, String>? queryParams,
    String? key,
    String? filePath,
    ContentHeaders? header,
    bool auth = true,
  }) async {
    http.Response response;
    Uri url = Uri.parse(useBaseUri ? "$_baseUri$endpoint" : endpoint);
    Map<String, String> headers = {};

    // if (auth)
    //   headers = {
    //     HttpHeaders.authorizationHeader:
    //         "Bearer ${await getIt<SecureStorageHelper>().getData(SecureStorageHelper.access_token)}"
    //   };

    switch (header) {
      case ContentHeaders.JSON:
        headers.addAll({HttpHeaders.contentTypeHeader: "application/json"});
        break;
      case ContentHeaders.URLEncoded:
        headers.addAll({
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        });
        break;
      case ContentHeaders.FormData:
        headers.addAll({HttpHeaders.contentTypeHeader: "multipart/form-data"});
        break;
      default:
        print('no headers');
        break;
    }

    try {
      print(
          '$request  http:/$endpoint request_body=> $body queryParams=> $queryParams');
      switch (request) {
        case Request.GET:
          if (queryParams != null) url.queryParameters.addAll(queryParams);

          response = await client.get(url, headers: headers);
          break;
        case Request.POST:
          response = await client.post(
            url,
            body: header == ContentHeaders.JSON ? json.encode(body) : body,
            headers: headers,
          );
          break;
        case Request.PATCH:
          response = await client.patch(
            url,
            body: header == ContentHeaders.JSON ? json.encode(body) : body,
            headers: headers,
          );
          break;
        case Request.PUT:
          response = await client.put(
            url,
            body: header == ContentHeaders.JSON ? json.encode(body) : body,
            headers: headers,
          );
          break;
        case Request.DELETE:
          response = await client.delete(url, headers: headers, body: body);
          break;
        case Request.PUTFile:
          print('file upload $key $filePath');
          http.MultipartRequest fileRequest = http.MultipartRequest('PUT', url);
          fileRequest.headers.addAll(headers);
          print(fileRequest.headers);
          fileRequest.files
              .add(await http.MultipartFile.fromPath(key!, filePath!));
          response = await http.Response.fromStream(await fileRequest.send());
          debugPrint(response.body);
          break;
        default:
          throw Exception('Req Type is null');
      }
      print(
          'http:/$endpoint response=> ${response.statusCode} ${response.body}');
      HTTPResponse httpResponse = HTTPResponse(
        status: response.statusCode,
        body: response.body.isNotEmpty ? json.decode(response.body) : null,
        headers: response.headers,
      );

      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          print('in case ${response.statusCode}');
          return httpResponse;
        case 400:
          Utils.showToast(msg: 'Error ${response.statusCode}');
          return null;
        case 401:
          Utils.showToast(msg: 'Unauthorised ${response.statusCode}');
          return null;
        case 404:
          Utils.showToast(msg: 'Not Found');
          return httpResponse;
        case 500:
          Utils.showToast(msg: 'Internal Server Error, please retry later');
          return null;
        default:
          print('unknown case ${response.statusCode}');
          Utils.showToast(msg: 'Something Went Wrong, please retry later');
          return null;
      }
    } on SocketException {
      debugPrint("no internet");
      Utils.showToast(msg: 'No Internet Connectivity');
      return null;
    } catch (err, stk) {
      debugPrint('exception from interceptor ${err.toString()} $stk');
      Utils.showToast(msg: "Something Went Wrong, Retry Later");
      return null;
    }
  }
}

enum ContentHeaders { JSON, URLEncoded, FormData }
enum Request { GET, POST, PATCH, PUT, DELETE, DELETEWithBody, PUTFile }
