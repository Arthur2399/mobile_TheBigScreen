
import 'dart:convert';
import 'package:cinema_mobile/src/core/app_config.dart';
import 'package:cinema_mobile/src/core/connection/generic_connector.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/models/token.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'dart:developer';



class LoginConnector extends GenericConnector {

  Future<Token> postLogin(String username, String password) async {
    var url = getServiceUrl(AppConfig.CONFIG_API_SERV_LOGIN);

    if (!AppConfig.CONFIG_APP_MOCK_SERVICE) {
     
      log('POST $url: { $username, $password}');

      final response = await http.post(Uri.parse(url),
          body: <String, String>{'username': username, 'password': password});

      if (response.statusCode == 200) {
        Map<String, String> computeParams = {
          'responseBody': response.body
        };
        // Use the compute function to run parse in a separate isolate.
        return compute(_parsePostLogin, computeParams);
      } else {
        return Future.error('Error El Usuario Ingresado Es Incorrecto');
      }

    } else {
      log('Simulating POST $url: {$username , $password}');
      return _postRegisterMock();
    }
  }

     Future<ApiResponse> resetPasswort(String email) async {
    var url = getServiceUrl(AppConfig.CONFIG_API_SERV_RESET_PASSWORD);

    if (!AppConfig.CONFIG_APP_MOCK_SERVICE) {
     
      log('POST $url: {  $email}');

      final response = await http.post(Uri.parse(url),
          body: <String, String>{ 'email': email});

      if (response.statusCode == 201) {
        // Use the compute function to run parse in a separate isolate.
        return compute(_parsePostResetPassword, utf8.decode(response.bodyBytes));
      } else {
        return Future.error('Ocurrió un error. Por favor intente mas tarde');
      }

    } else {
      log('Simulating POST $url:  $email}');
      return _createResetPasswordMock();
    }
  }
  
  Future<ApiResponse> _createResetPasswordMock() async {
    return Future.delayed(const Duration(milliseconds: 2000)).then((onValue) {
      ApiResponse apiResponse =
          ApiResponse(true, "La contraseña a sido cambiada exitosamente", null);
      return apiResponse;
    });
  }

  Future<Token> _postRegisterMock() async {
    return Future.delayed(const Duration(milliseconds: 2000)).then((onValue) {
      ApiResponse apiResponse = ApiResponse(
          true,
          "",
          Token(
              "",
          ));
      return apiResponse.response as Token;

    });
  }
  
  Token _parsePostLogin(Map<String, String> computeParams) {
    Map<String, dynamic> jsonApiResponse = jsonDecode(computeParams['responseBody']!);

    Token token = Token.fromJson(jsonApiResponse);
    return token;
  }

    ApiResponse _parsePostResetPassword(String responseBody) {
     ApiResponse apiResponse =
          ApiResponse(true, "Cliente creado exitosamente", responseBody);
    
    return apiResponse;
  }
  
}

