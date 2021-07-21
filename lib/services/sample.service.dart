import 'package:flutter_starter/globals.dart';
import 'package:flutter_starter/utils/http.interceptor.dart';
import 'package:flutter_starter/utils/http_response.dart';
import 'package:flutter_starter/utils/utilities.dart';

class SampleService {
  Future<HTTPResponse?> getUserList(Map<String, dynamic> user) async {
    return await interceptor
        .restCall(
          '/users',
          request: Request.POST,
          header: ContentHeaders.JSON,
          body: user,
        )
        .then((HTTPResponse? res) => res)
        .catchError(
      (error, stack) async {
        print('exception from Service ${error.toString()}');
        Utils.showToast(msg: 'Some Error Occurred, Please try again');
        return null;
      },
    );
  }
}
