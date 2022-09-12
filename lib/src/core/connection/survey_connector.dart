import 'dart:convert';
import 'dart:developer';


import 'package:cinema_mobile/src/core/app_config.dart';
import 'package:cinema_mobile/src/core/connection/generic_connector.dart';
import 'package:cinema_mobile/src/models/answersurvey.dart';
import 'package:cinema_mobile/src/models/api_response.dart';

import 'package:cinema_mobile/src/models/reawrds_model.dart';
import 'package:cinema_mobile/src/models/survey_get_model.dart';

import 'package:flutter/foundation.dart';

class SurveysConnector extends GenericConnector {

 Future<ApiResponse> fetchSurvey() async {
    String resource = AppConfig.CONFIG_API_SERV_GET_SURVEY;
    
    if (!AppConfig.CONFIG_APP_MOCK_SERVICE) {
      final response = await httpGet(resource);
     

      if (response.statusCode == 200) {
        return compute(_parseFetchSurveys, utf8.decode(response.bodyBytes));
      } else {
        throw  Exception(parseErrorMessage(utf8.decode(response.bodyBytes)));
      }
    } else {
      log('Simulating GET $resource');
      return _fetchSurveysMock();
    }
  }

 ApiResponse _parseFetchSurveys(String responseBody) {
    List<Surveys> resultSurveys = [];
   List<dynamic> listSurveys = json.decode(responseBody, );

    

      for (var item in listSurveys) {
        final survey = Surveys.fromJson(item!);
        resultSurveys.add(survey);
      }
  
    ApiResponse appres = ApiResponse(true, "succes", resultSurveys);



    return appres;
  }

  Future<ApiResponse> _fetchSurveysMock() async {
    return Future.delayed(const Duration(milliseconds: 2000)).then((onValue) {
      ApiResponse apiResponse = ApiResponse(true, "", Reward.getAllRewards());
      return apiResponse;
    });
  }

   Future<ApiResponse> sendAnswer(int id, AnswerSurvey answers) async {
     String resource = AppConfig.CONFIG_API_SERV_POST_SURVEY+id.toString();
    if (!AppConfig.CONFIG_APP_MOCK_SERVICE) {
      final response = await httpPostAuth(resource, jsonEncode(answers.toJson()));

      if (response.statusCode == 200) {
        // Use the compute function to run parse in a separate isolate.
        return compute(_parsePostAnswerSurvey, utf8.decode(response.bodyBytes));
      } else {
        throw  Exception(parseErrorMessage(utf8.decode(response.bodyBytes)));
      }
    } else {
      log('Simulating POST $resource');
      return _createAnswerSurveyMock();
    }
    
  }

  Future<ApiResponse> _createAnswerSurveyMock() async {
    return Future.delayed(const Duration(milliseconds: 2000)).then((onValue) {
      ApiResponse apiResponse =
          ApiResponse(true, "La respuestas han sido enviadas correctamente", null);
      return apiResponse;
    });
  }

  ApiResponse _parsePostAnswerSurvey(String responseBody) {
    ApiResponse apiResponse =
        ApiResponse(true, "Respuestas enviadas exitosamente", responseBody);

    return apiResponse;
  }
}