import 'dart:developer';
import 'package:dio/dio.dart';

class LoggingDioInterceptor implements Interceptor {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log("message ==> response  $err ${err.response?.statusCode}    ${err.response?.data}");
    if (err.response?.statusCode == 401) {
      log('', error: '401');
    }
    handler.next(err);
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    log("message ==> response  $response ${response.statusCode}    ${response.data}");
    if (response.statusCode == 200 && response.data is Map) {
      if(response.data["message"] == "Token Time Expire.") {
        log('', error: '401');
      }

      // getX.Get.offAll(() => SignInUpScreen());
    }
    handler.next(response);
  }
}
