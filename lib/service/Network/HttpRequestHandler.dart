import 'dart:convert';

import 'package:farmapp/controller/app_controller.dart';
import 'package:farmapp/views/widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'HttpConstants.dart';
import 'error_response_model.dart';

class HttpRequestHandler {
  String requestType = 'POST';
  late Map<String, dynamic> responsebody;
  late ErrorResponse error;

  Future<bool> sendTokenServerRequest(String urlExtension, dynamic body) async {
    AppController controller = Get.find();
    var token = 'controller.token';
    print(token);
    print(urlExtension);
    print(body);
    var isScuccess;
    var response = await http.post(
        Uri.https(HttpConstants.baseUrl, urlExtension),
        body: jsonEncode(body),
        // ignore: unnecessary_null_comparison
        headers: token == null
            ? {"Accept": "application/json", "content-type": "application/json"}
            : {
                "Accept": "application/json",
                "content-type": "application/json",
                "Authorization": "Bearer " + token
              });
    print('response code');
    print(response.statusCode);
    print(response.body);
    if (response.body.isNotEmpty) {
      var resData = jsonDecode(response.body) as Map<String, dynamic>;
      responsebody = resData;
    }
    if (response.statusCode == 200 || response.statusCode == 204) {
      isScuccess = true;
    } else if (response.statusCode == 400) {
      if (responsebody.containsKey('responseMessage')) {
        print(response.body);
        error = ErrorResponse.fromJson(responsebody);
        print(error.responseMessage);
        // ignore: unnecessary_null_comparison
        if (error.responseMessage != null && responsebody != null) {
          Get.dialog(errorDialog(error.responseMessage));
        } else {
          Get.dialog(errorDialog('Something went wrong'));
        }
      }
      isScuccess = false;
    } else {
      isScuccess = false;
      Get.dialog(errorDialog('Something went wrong'));
    }
    return isScuccess;
  }
}
