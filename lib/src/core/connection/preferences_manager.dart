// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:cinema_mobile/src/models/answersurvey.dart';
import 'package:cinema_mobile/src/models/movies.dart';
import 'package:cinema_mobile/src/models/reawrds_model.dart';
import 'package:cinema_mobile/src/models/survey_get_model.dart';
import 'package:cinema_mobile/src/models/token.dart';
import 'package:cinema_mobile/src/models/top5movies_model.dart';
import 'package:cinema_mobile/src/models/user.dart';
import 'package:cinema_mobile/src/models/userRegister.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const String _KEY_TOKEN = 'KEY_TOKEN';
  static const String _KEY_LOGIN = 'KEY_LOGIN';

  static const String _KEY_USER = 'KEY_USER';
  static const String _KEY_PENDING_USER = 'KEY_PENDING_USER';

  static const String _KEY_REGISTER_USER = 'KEY_REGISTER_USER';
  static const String _KEY_PENDING_REGISTER_USER = 'KEY_PENDING_REGISTER_USER';

  static const String _KEY_MOVIES = 'KEY_MOVIES';
  static const String _KEY_PENDING_MOVIES = 'KEY_PENDING_MOVIES';

  
  static const String _KEY_TOP5MOVIES = 'KEY_TOP5MOVIES';
  static const String _KEY_PENDING_TOP5MOVIES = 'KEY_PENDING_TOP5MOVIES';

  static const String _KEY_REWARDS = 'KEY_REWARDS';
  static const String _KEY_PENDING_REWARDS = 'KEY_PENDING_REWARDS';

  static const String _KEY_SURVEYS = 'KEY_SURVEYS';
  static const String _KEY_PENDING_SURVEYS = 'KEY_PENDING_SURVEYS';

  static const String _KEY_ANSWER_SURVEYS = 'KEY_ANSWER_SURVEYS';
  static const String _KEY_ANSWER_PENDING_SURVEYS =
      'KEY_ANSWER_PENDING_SURVEYS';

  static saveToken(Token? token, bool savetoken) async {
    final prefs = await SharedPreferences.getInstance();
    if (token != null) {
      var jsonToken = jsonEncode(token);
      prefs.setString(_KEY_TOKEN, jsonToken);
    } else {
      prefs.remove(_KEY_TOKEN);
    }
  }

  static Future<Token?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var jsonUser = prefs.getString(_KEY_TOKEN);
    if (jsonUser != null) {
      Map<String, dynamic> userMap = jsonDecode(jsonUser);
      return Token.fromJson(userMap);
    }

    return null;
  }

  static Future<bool> isLogedIn() async {
    final prefs = await SharedPreferences.getInstance();
    var jsonUser = prefs.getString(_KEY_TOKEN);
    return jsonUser != null;
  }

  static saveUserPending(User user) async {
    List<User>? pendingUser = await getUsers(true);
    pendingUser ??= [];

    pendingUser.insert(0, user);
    await saveUsers(pendingUser, true);
  }

  static saveUserRegisterPending(userRegister user) async {
    List<userRegister>? pendingUser = await getRegisterUsers(true);
    pendingUser ??= [];

    pendingUser.insert(0, user);
    await saveRegisterUsers(pendingUser, true);
  }

  static Future<List<userRegister>?> getRegisterUsers(bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_REGISTER_USER : _KEY_PENDING_REGISTER_USER;

    var jsonStrClients = prefs.getString(key);
    if (jsonStrClients != null) {
      List<dynamic> jsonClients = jsonDecode(jsonStrClients);
      return jsonClients
          .map<userRegister>((json) => userRegister.fromJson(json))
          .toList();
    }

    return null;
  }

  static saveRegisterUsers(List<userRegister> user, bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_REGISTER_USER : _KEY_PENDING_REGISTER_USER;

    var jsonStrClients = jsonEncode(user);
    prefs.setString(key, jsonStrClients);
  }

  static saveUsers(List<User> user, bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_USER : _KEY_PENDING_USER;

    var jsonStrClients = jsonEncode(user);
    prefs.setString(key, jsonStrClients);
  }

  static Future<List<User>?> getUsers(bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_USER : _KEY_PENDING_USER;

    var jsonStrClients = prefs.getString(key);
    if (jsonStrClients != null) {
      List<dynamic> jsonClients = jsonDecode(jsonStrClients);
      return jsonClients.map<User>((json) => User.fromJson(json)).toList();
    }

    return null;
  }

  static saveMoviesPending(Movies movie) async {
    List<Movies>? pendingMovies = await getMovies(true);
    pendingMovies ??= [];

    pendingMovies.insert(0, movie);
    await saveMovies(pendingMovies, true);
  }

  static saveMovies(List<Movies> movie, bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_MOVIES : _KEY_PENDING_MOVIES;

    var jsonStrMovies = jsonEncode(movie);
    prefs.setString(key, jsonStrMovies);
  }

  static Future<List<Movies>?> getMovies(bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_MOVIES : _KEY_PENDING_MOVIES;

    var jsonStrMovies = prefs.getString(key);
    if (jsonStrMovies != null) {
      List<dynamic> jsonMovies = jsonDecode(jsonStrMovies);
      return jsonMovies.map<Movies>((json) => Movies.fromJson(json)).toList();
    }

    return null;
  }

  static saveRewardsPending(Reward reward) async {
    List<Reward>? pendingRewards = await getRewards(true);
    pendingRewards ??= [];

    pendingRewards.insert(0, reward);
    await saveRewards(pendingRewards, true);
  }

  static saveRewards(List<Reward> rewards, bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_REWARDS : _KEY_PENDING_REWARDS;

    var jsonStrRewards = jsonEncode(rewards);
    prefs.setString(key, jsonStrRewards);
  }

  static Future<List<Reward>?> getRewards(bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_REWARDS : _KEY_PENDING_REWARDS;

    var jsonStrRewards = prefs.getString(key);
    if (jsonStrRewards != null) {
      List<dynamic> jsonRewards = jsonDecode(jsonStrRewards);
      return jsonRewards.map<Reward>((json) => Reward.fromJson(json)).toList();
    }

    return null;
  }

  static saveSurveysPending(Surveys survey) async {
    List<Surveys>? pendingSurveys = await getSurveys(true);
    pendingSurveys ??= [];

    pendingSurveys.insert(0, survey);
    await saveSurveys(pendingSurveys, true);
  }

  static saveSurveys(List<Surveys> survey, bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_SURVEYS : _KEY_PENDING_SURVEYS;

    var jsonStrRewards = jsonEncode(survey);
    prefs.setString(key, jsonStrRewards);
  }

  static Future<List<Surveys>?> getSurveys(bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_SURVEYS : _KEY_PENDING_SURVEYS;

    var jsonStrSurveys = prefs.getString(key);
    if (jsonStrSurveys != null) {
      List<dynamic> jsonSurveys = jsonDecode(jsonStrSurveys);
      return jsonSurveys
          .map<Surveys>((json) => Surveys.fromJson(json))
          .toList();
    }

    return null;
  }

  static saveAnswerSurveysPending(AnswerSurvey answer) async {
    List<AnswerSurvey>? pendingAnswerSurvey = await getAnswerSurveys(true);
    pendingAnswerSurvey ??= [];

    pendingAnswerSurvey.insert(0, answer);
    await saveAnswerSurveys(pendingAnswerSurvey, true);
  }

  static saveAnswerSurveys(List<AnswerSurvey> survey, bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_ANSWER_SURVEYS : _KEY_ANSWER_PENDING_SURVEYS;

    var jsonStrRewards = jsonEncode(survey);
    prefs.setString(key, jsonStrRewards);
  }

  static Future<List<AnswerSurvey>?> getAnswerSurveys(bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_ANSWER_SURVEYS : _KEY_ANSWER_PENDING_SURVEYS;

    var jsonStrAnswerSurvey = prefs.getString(key);
    if (jsonStrAnswerSurvey != null) {
      List<dynamic> jsonAnswerSurvey = jsonDecode(jsonStrAnswerSurvey);
      return jsonAnswerSurvey
          .map<AnswerSurvey>((json) => AnswerSurvey.fromJson(json))
          .toList();
    }

    return null;
  }

    static saveTop5MoviesPending(Top5Movies top5movie) async {
    List<Top5Movies>? pendingTop5Movies = await getTop5Movies(true);
    pendingTop5Movies ??= [];

    pendingTop5Movies.insert(0, top5movie);
    await saveTop5Movies(pendingTop5Movies, true);
  }

  static saveTop5Movies(List<Top5Movies> top5movie, bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_TOP5MOVIES : _KEY_PENDING_TOP5MOVIES;

    var jsonStrTop5Movies = jsonEncode(top5movie);
    prefs.setString(key, jsonStrTop5Movies);
  }

  static Future<List<Top5Movies>?> getTop5Movies(bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    final key = !pending ? _KEY_TOP5MOVIES : _KEY_PENDING_TOP5MOVIES;
    var jsonStrTop5Movies = prefs.getString(key);
    if (jsonStrTop5Movies != null) {
      List<dynamic> jsonTop5Movies = jsonDecode(jsonStrTop5Movies);
      return jsonTop5Movies.map<Top5Movies>((json) => Top5Movies.fromJson(json)).toList();
    }

    return null;
  }
  //////////////////////////////////////////////////////////////////////////////
  // Generic
  //////////////////////////////////////////////////////////////////////////////

  static clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

    static Future<User?> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    var jsonUser = prefs.getString(_KEY_LOGIN);
    if (jsonUser != null) {
      Map<String, dynamic> userMap = jsonDecode(jsonUser);
      return User.fromJson(userMap);
    }

    return null;
  }

}
