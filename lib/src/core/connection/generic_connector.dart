import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cinema_mobile/src/core/app_config.dart';
import 'package:cinema_mobile/src/core/connection/preferences_manager.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/models/token.dart';
import 'package:http/http.dart' as http;




class GenericConnector {
  final String baseUrl = AppConfig.CONFIG_API_URL;

  String getServiceUrl(String serviceUrl) {
    return baseUrl + serviceUrl;
  }

 
  Future<String> getAuthHeader() async {

    Token? token = await PreferenceManager.getToken();
    if (token != null) {
      String tok = "token "+token.token.toString();
      return tok;
    }

    return '';
  }


  //////////////////////////////////////////////////////////////////////////////
  // Connection
  //////////////////////////////////////////////////////////////////////////////


  /// Generic POST request with headers and timeout
  Future<http.Response> httpPost(String resource, String body) async {
    var url = getServiceUrl(resource);
    var uri = Uri.parse(url);
    log('POST $uri');

   
    final response = await http
        .post(uri,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
            },
            body: body)
        .timeout(const Duration(seconds: AppConfig.CONFIG_API_TIMEOUT));

    log('Response: ' + response.body);
    return response;
  }

    Future<http.Response> httpPostAuth(String resource, String body) async {
    var url = getServiceUrl(resource);
    var uri = Uri.parse(url);
     String authHeader = await getAuthHeader();
    log('POST $uri');

   
    final response = await http
        .post(uri,
            headers: {
               HttpHeaders.authorizationHeader: authHeader,
              HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
            },
            body: body)
        .timeout(const Duration(seconds: AppConfig.CONFIG_API_TIMEOUT));

    log('Response: ' + response.body);
    return response;
  }

   Future<http.Response> httpGet(String resource,
      {Map<String, dynamic>? queryParams}) async {
    var url = getServiceUrl(resource);
    var uri = Uri.parse(url).replace(queryParameters: queryParams);
    log('GET $uri');

    String authHeader = await getAuthHeader();
    final response = await http
        .get(uri,
          headers: {
            HttpHeaders.authorizationHeader: authHeader,
          })
        .timeout(const Duration(seconds: AppConfig.CONFIG_API_TIMEOUT));

    log('Response: ' + response.body);
    return response;
  }

  //////////////////////////////////////////////////////////////////////////////
  // Response
  //////////////////////////////////////////////////////////////////////////////

  /// Method to extract error message from ApiResponse
  String parseErrorMessage(String responseBody) {
    String message = responseBody;
    try {
      Map<String, dynamic> jsonApiResponse = jsonDecode(responseBody);
     ApiResponse apiResponse =
          ApiResponse(false, "", responseBody);
      
     return apiResponse.response!;
    } catch (e) {
      log(e.toString());
       return e.toString();
  }
    
  }
}