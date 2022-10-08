class GlobalConfig {
  //Keys
  static const String vitalKeys = 'keys';
  // Dio
  static const int connectTimeOut = 30000;
  static const int receiveTimeout = 30000;

  // Service name
  static const String baseService = 'base';

  // Service URL
  static const Map<String, String> configUrlDebug = {
    baseService: 'https://api.themoviedb.org/3/movie/550?api_key=a67a1892b7a906a0b14c396efa3502eb',
  };
}
