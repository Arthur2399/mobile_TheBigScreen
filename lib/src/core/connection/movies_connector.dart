import 'dart:convert';
import 'dart:developer';

import 'package:cinema_mobile/src/core/app_config.dart';
import 'package:cinema_mobile/src/core/connection/generic_connector.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/models/movies.dart';
import 'package:cinema_mobile/src/models/movies_model.dart';
import 'package:cinema_mobile/src/models/top5movies_model.dart';
import 'package:flutter/foundation.dart';

class MoviesConnecotr extends GenericConnector {
  Future<ApiResponse> fetchMovies() async {
    String resource = AppConfig.CONFIG_API_SERV_MOVIES;
    
    if (!AppConfig.CONFIG_APP_MOCK_SERVICE) {
      final response = await httpGet(resource);
     

      if (response.statusCode == 200) {
        return compute(_parseFetchMovies, utf8.decode(response.bodyBytes));
      } else {
        throw  Exception(parseErrorMessage(utf8.decode(response.bodyBytes)));
      }
    } else {
      log('Simulating GET $resource');
      return _fetchMoviesMock();
    }
  }

   ApiResponse _parseFetchMovies(String responseBody) {
    List<Movie> resultMovie = [];
   List<dynamic> listMovie = json.decode(responseBody, );

    

      for (var item in listMovie) {
        final movie = Movie.fromJson(item!);
        resultMovie.add(movie);
      }
  
    ApiResponse appres = ApiResponse(true, "succes", resultMovie);



    return appres;
  }

  Future<ApiResponse> _fetchMoviesMock() async {
    return Future.delayed(const Duration(milliseconds: 2000)).then((onValue) {
      ApiResponse apiResponse = ApiResponse(true, "", Movies.getAllMovies());
      return apiResponse;
    });
  }

//Top 5

  Future<ApiResponse> fetchTop5Movie() async {
    String resource = AppConfig.CONFIG_API_SERV_TOP5_MOVIES;
    
    if (!AppConfig.CONFIG_APP_MOCK_SERVICE) {
      final response = await httpGet(resource);
     

      if (response.statusCode == 200) {
        return compute(_parseFetchTop5Movies, utf8.decode(response.bodyBytes));
      } else {
        throw  Exception(parseErrorMessage(utf8.decode(response.bodyBytes)));
      }
    } else {
      log('Simulating GET $resource');
      return _fetchTop5MoviesMock();
    }
  }

   ApiResponse _parseFetchTop5Movies(String responseBody) {
    List<Top5Movies> resultMovie = [];
   List<dynamic> listMovie = json.decode(responseBody, );

    

      for (var item in listMovie) {
        final movie = Top5Movies.fromJson(item!);
        resultMovie.add(movie);
      }
  
    ApiResponse appres = ApiResponse(true, "succes", resultMovie);



    return appres;
  }

  Future<ApiResponse> _fetchTop5MoviesMock() async {
    return Future.delayed(const Duration(milliseconds: 2000)).then((onValue) {
      ApiResponse apiResponse = ApiResponse(true, "", Movies.getAllMovies());
      return apiResponse;
    });
  }

}
