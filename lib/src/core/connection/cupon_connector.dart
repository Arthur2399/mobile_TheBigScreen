import 'dart:convert';
import 'dart:io';
import 'package:cinema_mobile/src/core/app_config.dart';
import 'package:cinema_mobile/src/core/connection/generic_connector.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'dart:developer';

class CuponConnector extends GenericConnector {
  Future<ApiResponse> addPointsCupon(String qr) async {
    var url = getServiceUrl(AppConfig.CONFIG_API_SERV_REGISTER_CUPON);
    String authHeader = await getAuthHeader();
    if (!AppConfig.CONFIG_APP_MOCK_SERVICE) {
      log('POST $url: {  $qr}');

      final response = await http.post(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: authHeader,
      }, body: <String, String>{
        'qr': qr
      });

      if (response.statusCode == 200) {

        // Use the compute function to run parse in a separate isolate.
        return compute(_parsePostQr, utf8.decode(response.bodyBytes));
      } else {
        return Future.error(response.body);
      }
    } else {
      log('Simulating POST $url:  $qr}');
      return _createQrMock();
    }
  }

  Future<ApiResponse> _createQrMock() async {
    return Future.delayed(const Duration(milliseconds: 2000)).then((onValue) {
      ApiResponse apiResponse =
          ApiResponse(true, "Qr Escaneado correctamente", null);
      return apiResponse;
    });
  }

  ApiResponse _parsePostQr(String responseBody) {
    ApiResponse apiResponse =
        ApiResponse(true, "Qr Escaneado correctamente", responseBody);

    return apiResponse;
  }
}
