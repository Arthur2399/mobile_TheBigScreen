import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';

import 'package:cinema_mobile/src/core/app_config.dart';
import 'package:cinema_mobile/src/core/connection/generic_connector.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/util/local_object_util.dart';
import 'package:cinema_mobile/src/models/user.dart';
import 'package:cinema_mobile/src/models/userRegister.dart';


class UsersConnector extends GenericConnector {

  Future<ApiResponse> fetchUsers() async {
    String resource = AppConfig.CONFIG_API_SERV_USER;

    if (!AppConfig.CONFIG_APP_MOCK_SERVICE) {
      final response = await httpGet(resource);

      if (response.statusCode == 200) {
        return compute(_parseFetchUser, utf8.decode(response.bodyBytes));
      } else {
        throw  Exception(parseErrorMessage(utf8.decode(response.bodyBytes)));
      }
    } else {
      log('Simulating GET $resource');
      return _fetchUserMock();
    }
  }
    Future<ApiResponse> _fetchUserMock() async {
    return Future.delayed(const Duration(milliseconds: 2000)).then((onValue) {
      ApiResponse apiResponse = ApiResponse(true, "", User.getAllUsers());
      return apiResponse;
    });
  }
   ApiResponse _parseFetchUser(String responseBody) {
    Map<String, dynamic> jsonApiResponse = jsonDecode(responseBody);
   
  
   ApiResponse  appres = ApiResponse(true, "succes", jsonApiResponse); 
   
    appres.response = User.fromJson(jsonApiResponse);
     appres.source = ApiResponseSource.remote;


    return appres;
  }

   Future<ApiResponse> createUser(userRegister user) async {
    String resource = AppConfig.CONFIG_API_SERV_REGISTER;

    if (!AppConfig.CONFIG_APP_MOCK_SERVICE) {
      final response = await httpPost(resource, jsonEncode(user.toJson()));

      if (response.statusCode == 201) {
        // Use the compute function to run parse in a separate isolate.
        return compute(_parsePostCreateClient, utf8.decode(response.bodyBytes));
      } else {
        throw  Exception(parseErrorMessage(utf8.decode(response.bodyBytes)));
      }
    } else {
      log('Simulating POST $resource');
      return _createClienMock();
    }
  }

  Future<ApiResponse> _createClienMock() async {
    return Future.delayed(const Duration(milliseconds: 2000)).then((onValue) {
      ApiResponse apiResponse =
          ApiResponse(true, "Cliente creado exitosamente", null);
      return apiResponse;
    });
  }

  ApiResponse _parsePostCreateClient(String responseBody) {

    
  ApiResponse apiResponse =
          ApiResponse(true, "Cliente creado exitosamente", responseBody);
    
    return apiResponse;
  }
 
}