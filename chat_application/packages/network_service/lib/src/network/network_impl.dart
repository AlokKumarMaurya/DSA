import 'dart:io';

import 'package:get/get.dart';

import 'base_network.dart';

class Network implements BaseNetwork {
  final GetConnect _connect = GetConnect();

  @override
  Future<Map<String, dynamic>?> get(
      {required String url, query, required Map<String, String> header}) async {
    try {
      var response = await _connect.get(url, query: query, headers: header);
      return _returnResponse(response: response);
    } on SocketException {
      Get.snackbar("Error", "Check you internet connection");
    } catch (_) {
      Get.snackbar("Error", "Some error occurred");
    }
    return null;
  }

  Map<String, dynamic> _returnResponse({required Response response}) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      default:
        throw Exception(response.statusCode);
    }
  }

  @override
  Future<Map<String, dynamic>?> post({
    required String url,
    required dynamic body,
    required dynamic header,
    dynamic query,
  }) async {
    try {

      var response = await _connect.post(url, body, headers: header);
      return _returnResponse(response: response);
    } on SocketException {
      Get.snackbar("Error", "Check you internet connection");
    } catch (e) {
      Get.snackbar("Error", "Some error occurred");
    }
    return null;
  }
}
