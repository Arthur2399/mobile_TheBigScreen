import 'dart:convert';
import 'dart:developer';

import 'package:cinema_mobile/src/core/app_config.dart';
import 'package:cinema_mobile/src/core/connection/generic_connector.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/models/reawrds_model.dart';

import 'package:flutter/foundation.dart';

class RewardsConnector extends GenericConnector {

 Future<ApiResponse> fetchReward() async {
    String resource = AppConfig.CONFIG_API_SERV_REWARDS;
    
    if (!AppConfig.CONFIG_APP_MOCK_SERVICE) {
      final response = await httpGet(resource);
     

      if (response.statusCode == 200) {
        return compute(_parseFetchRewards, utf8.decode(response.bodyBytes));
      } else {
        throw  Exception(parseErrorMessage(utf8.decode(response.bodyBytes)));
      }
    } else {
      log('Simulating GET $resource');
      return _fetchRewardsMock();
    }
  }

 ApiResponse _parseFetchRewards(String responseBody) {
    List<Reward> resultRewards = [];
   List<dynamic> listSurveys = json.decode(responseBody, );

    

      for (var item in listSurveys) {
        final reward = Reward.fromJson(item!);
        resultRewards.add(reward);
      }
  
    ApiResponse appres = ApiResponse(true, "succes", resultRewards);



    return appres;
  }

  Future<ApiResponse> _fetchRewardsMock() async {
    return Future.delayed(const Duration(milliseconds: 2000)).then((onValue) {
      ApiResponse apiResponse = ApiResponse(true, "", Reward.getAllRewards());
      return apiResponse;
    });
  }

}