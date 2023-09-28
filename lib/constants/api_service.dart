import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class Api {
  final dio = Dio();
  final formData = FormData();

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? queryData,
    Map<String, String>? header,
    dynamic bodyData,
  }) async {
    log('bodyData: ${jsonEncode(bodyData)}');
    final response = await dio.post(
      url,
      data: bodyData,
    );
    return response;
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryData,
  }) async {
    final response = await dio.get(url);
    log('get api response: ${response}');
    return response;
  }

  Map<String, String> headers() {
    final Map<String, String> headers = <String, String>{};
    // headers["Content-Type"] = "application/x-www-form-urlencoded";
    headers["Accept"] = "application/json";
    final String token = "";
    log('Authorization Token : $token');
    if (token != '') {
      headers["Authorization"] = token;
      // headers["X-token"] = '$token';
    }
    return headers;
  }
}
