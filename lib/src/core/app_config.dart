// ignore_for_file: constant_identifier_names

class AppConfig {
  static const bool CONFIG_APP_MOCK_SERVICE = false;

  // Sync Service
  /// Interval for Sync Service. Value in minutes
  static const int CONF_SYNC_SERVICE_INTERVAL = 60 * 2;

  // API Connection

  /// Connection timeout for API requests. Value in seconds
  static const int CONFIG_API_TIMEOUT = 50;

  //static const String CONFIG_API_URL = 'http://10.0.2.2:8080/api';
  //static const String CONFIG_API_URL = 'http://192.168.194.46:8080/api-mobile-erp/api';
  //EMULAR
  //static const String CONFIG_API_URL = 'http://10.0.2.2:8087';
  //FISICO
  static const String CONFIG_API_URL = 'http://154.12.236.19:83';
  static const String CONFIG_API_SERV_REGISTER = '/user/createu';
  static const String CONFIG_API_SERV_LOGIN = '/user/api-token-auth';
  static const String CONFIG_API_SERV_USER = '/user/user';
  static const String CONFIG_API_SERV_MOVIES = '/movies/movies/list';
  static const String CONFIG_API_SERV_RESET_PASSWORD = '/mail/Changepassword';
  static const String CONFIG_API_SERV_REWARDS = '/points/awards/list';
  static const String CONFIG_API_SERV_REGISTER_CUPON = '/points/ticket/read';
  static const String CONFIG_API_SERV_GET_SURVEY = '/survey/survey/usr';
  static const String CONFIG_API_SERV_POST_SURVEY = '/survey/survey/answer/';
  static const String CONFIG_API_SERV_TOP5_MOVIES = '/movies/movies/best5';
}
