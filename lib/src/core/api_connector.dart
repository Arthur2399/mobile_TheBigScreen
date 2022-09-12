import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cinema_mobile/src/core/connection/movies_connector.dart';
import 'package:cinema_mobile/src/core/connection/preferences_manager.dart';
import 'package:cinema_mobile/src/core/connection/rewards_connector.dart';
import 'package:cinema_mobile/src/core/connection/survey_connector.dart';
import 'package:cinema_mobile/src/core/connection/user_connection.dart';
import 'package:cinema_mobile/src/models/answersurvey.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/util/local_object_util.dart';
import 'package:cinema_mobile/src/models/movies.dart';
import 'package:cinema_mobile/src/models/reawrds_model.dart';
import 'package:cinema_mobile/src/models/survey_get_model.dart';
import 'package:cinema_mobile/src/models/top5movies_model.dart';
import 'package:cinema_mobile/src/models/user.dart';
import 'package:cinema_mobile/src/models/userRegister.dart';


class ApiConnector {
  late  List<User> arrayUser; 
  late List<Movies> arrayMovies;

  late UsersConnector _usersConnector;
  late MoviesConnecotr _moviesConnecotr;
  late RewardsConnector _rewardsConnector;
  late SurveysConnector _surveysConnector;
  ApiConnector() {

    _usersConnector = UsersConnector();
    _moviesConnecotr = MoviesConnecotr();
    _rewardsConnector = RewardsConnector();
    _surveysConnector = SurveysConnector();

  }

     Future<ApiResponse> fetchSurveys() async {
    try {
      ApiResponse apiResponse = await _surveysConnector.fetchSurvey();
      if (apiResponse.success == true &&
          apiResponse.source == ApiResponseSource.remote) {
        PreferenceManager.saveSurveysPending(apiResponse.response);
      }

      return apiResponse;
    } catch (e) {
      log('Error fetching Surveys: ' + e.toString());
      if (e is SocketException || e is TimeoutException) {
        return _errorFetchSurveys(
            'Al momento no tienes conexión a internet. No fue posible obtener las Encuestas.');
      } else {
        return _errorFetchSurveys(e.toString());
      }
    }
  }
   
   Future<ApiResponse> fetchMovies() async {
    try {
      ApiResponse apiResponse = await _moviesConnecotr.fetchMovies();
      if (apiResponse.success == true &&
          apiResponse.source == ApiResponseSource.remote) {
        PreferenceManager.saveMoviesPending(apiResponse.response);
      }

      return apiResponse;
    } catch (e) {
      log('Error fetching Movies: ' + e.toString());
      if (e is SocketException || e is TimeoutException) {
        return _errorFetchMovies(
            'Al momento no tienes conexión a internet. No fue posible obtener las peliculas.');
      } else {
        return _errorFetchMovies(e.toString());
      }
    }
  }

     Future<ApiResponse> fetchTop5Movies() async {
    try {
      ApiResponse apiResponse = await _moviesConnecotr.fetchTop5Movie();
      if (apiResponse.success == true &&
          apiResponse.source == ApiResponseSource.remote) {
        PreferenceManager.saveTop5MoviesPending(apiResponse.response);
      }

      return apiResponse;
    } catch (e) {
      log('Error fetching Top5Movies: ' + e.toString());
      if (e is SocketException || e is TimeoutException) {
        return _errorFetchTop5Movies(
            'Al momento no tienes conexión a internet. No fue posible obtener el top 5 peliculas.');
      } else {
        return _errorFetchTop5Movies(e.toString());
      }
    }
  }

   Future<ApiResponse> fetchRewards() async {
    try {
      ApiResponse apiResponse = await _rewardsConnector.fetchReward();
      if (apiResponse.success == true &&
          apiResponse.source == ApiResponseSource.remote) {
        PreferenceManager.saveRewardsPending(apiResponse.response);
      }

      return apiResponse;
    } catch (e) {
      log('Error fetching Movies: ' + e.toString());
      if (e is SocketException || e is TimeoutException) {
        return _errorFetchRewards(
            'Al momento no tienes conexión a internet. No fue posible obtener las Premios.');
      } else {
        return _errorFetchRewards(e.toString());
      }
    }
  }


    Future<ApiResponse> fetchUser() async {
    try {
      ApiResponse apiResponse = await _usersConnector.fetchUsers();
      if (apiResponse.success == true &&
          apiResponse.source == ApiResponseSource.remote) {
        PreferenceManager.saveUserPending(apiResponse.response);
      }

      return apiResponse;
    } catch (e) {
      log('Error fetching Usuarios: ' + e.toString());
      if (e is SocketException || e is TimeoutException) {
        return _errorFetchUsers(
            'Al momento no tienes conexión a internet. No fue posible obtener los clientes.');
      } else {
        return _errorFetchUsers(e.toString());
      }
    }
  }

    Future<ApiResponse> createUsers(userRegister user) async {
    try {
      ApiResponse apiResponse = await _usersConnector.createUser(user);
      return apiResponse;
    } catch (e) {
      // If there is a connection error -> save the client as pending
      if ( e is TimeoutException) {
   
      
        PreferenceManager.saveUserRegisterPending(user);
        return _createLocalApiResponse(
            'Al momento no tienes conexión a internet. El cliente será creado más tarde.',
            user);
      } else {
        return _createLocalApiResponse("Error: ${e.toString()}", null);
      }
    }
  }

    Future<ApiResponse> sendAnswers(int id, AnswerSurvey answers) async {
    try {
      ApiResponse apiResponse = await _surveysConnector.sendAnswer(id, answers);
      return apiResponse;
    } catch (e) {
      // If there is a connection error -> save the client as pending
      if ( e is TimeoutException) {
   
      
        PreferenceManager.saveAnswerSurveysPending(answers);
        return _createLocalApiResponse(
            'Al momento no tienes conexión a internet. El cliente será creado más tarde.',
            answers);
      } else {
        return _createLocalApiResponse("Error :  ${e.toString()}", null);
      }
    }
  }
  
  Future<ApiResponse> _errorFetchUsers(String errorMessage) async {
    List<User>? clients = await PreferenceManager.getUsers(false);
    return _createLocalApiResponse(errorMessage, clients);
  }
Future<ApiResponse> _errorFetchMovies(String errorMessage) async {
    List<Movies>? movies = await PreferenceManager.getMovies(false);
    return _createLocalApiResponse(errorMessage, movies);
  }
  Future<ApiResponse> _errorFetchRewards(String errorMessage) async {
    List<Reward>? rewards = await PreferenceManager.getRewards(false);
    return _createLocalApiResponse(errorMessage, rewards);
  }
    Future<ApiResponse> _errorFetchSurveys(String errorMessage) async {
    List<Surveys>? surveys = await PreferenceManager.getSurveys(false);
    return _createLocalApiResponse(errorMessage, surveys);
  }
      Future<ApiResponse> _errorFetchTop5Movies(String errorMessage) async {
    List<Top5Movies>? top5movies = await PreferenceManager.getTop5Movies(false);
    return _createLocalApiResponse(errorMessage, top5movies);
  }

  Future<ApiResponse> _createLocalApiResponse(
      String errorMessage, dynamic response) {
    ApiResponse apiResponse = ApiResponse(false, errorMessage, response);

    if (response != null) {
      apiResponse.success = true;
      apiResponse.source = ApiResponseSource.local;
      apiResponse.requireAction = true;
      return Future.value(apiResponse);
    } else {
      return Future.error(apiResponse);
    }
  }

  
}