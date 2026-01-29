class ApiConstants {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String apiVersion = '/v1';
  static const String fullBaseUrl = '$baseUrl$apiVersion';

  // Endpoints
  static const String users = '/users';
  static const String api2 = '/endpoint2';
  static const String api3 = '/endpoint3';

  // headers
  static const String contentType = 'application/json';
  static const String authorization = 'Authorization';
  static const String acceptLanguage = 'Accept-Language';

  // timeout
  static const int connectTimeOutsMs = 15000;
  static const int receiveTimeOutsMs = 15000;
  static const int sendTimeOutsMs = 15000;
}
