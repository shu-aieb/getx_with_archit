import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:getx_with_archit/app/core/constants/api_constants.dart';
import 'package:getx_with_archit/app/data/services/storage_services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiProvider {
  static ApiProvider? _instance;
  late Dio _dio;
  final _storageService = getx.Get.find<StorageServices>();

  ApiProvider._internal() {
    _dio = Dio();
    _initializeInterceptors();
  }

  factory ApiProvider() {
    _instance ??= ApiProvider._internal();
    return _instance!;
  }

  void _initializeInterceptors() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConstants.connectTimeOutsMs),
      receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeOutsMs),
      sendTimeout: Duration(milliseconds: ApiConstants.sendTimeOutsMs),
      headers: {
        'Content-Type': ApiConstants.contentType,
        'Accept': ApiConstants.contentType,
      },
    );

    // Request Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Adds Token Headers
          final token = _storageService.token;
          if (token != null) {
            options.headers[ApiConstants.authorization] = 'Bearer $token';
          }

          // Adding Language Headers
          final language = _storageService.language ?? 'en';
          options.headers[ApiConstants.authorization] = language;

          // check connectivity
          final connectivity = Connectivity().checkConnectivity();
          if (connectivity == ConnectivityResult.none) {
            throw DioException(
              requestOptions: options,
              error: 'No Internet Connection',
              type: DioExceptionType.connectionError,
            );
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _handleTokenExpiration();
          }
          handler.next(error);
        },
      ),
    );

    // logger Interceptor (only for debug mode)
    if (getx.Get.isLogEnable) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
        ),
      );
    }
  }

  Future<void> _handleTokenExpiration() async {
    _storageService.removeToken();
    //navigate to login screen - if token is expired
    getx.Get.offAllNamed('/login');
  }

  // Creating API Calls

  // Generic Get Call
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path, // Question : If we are passing the path in every request get, put, post , delete then why we pass the base url in the interceptor?
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic Post Request
  Future<Response> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      throw _handleError(
        e,
      ); // Question : Why are we throwing another exception when we catch an exception
    }
  }

  _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Exception('Connection Timeout');
        case DioExceptionType.sendTimeout:
          return Exception('Send Timeout');
        case DioExceptionType.receiveTimeout:
          return Exception('Receive Timeout');
        case DioExceptionType.badResponse:
          return Exception(_handleStatusCode(error.response?.statusCode));
        case DioExceptionType.cancel:
          return Exception('Request Cancelled');
        case DioExceptionType.unknown:
          return Exception('Unknown Error');
        default:
          return Exception('Something Went Wrong');
      }
    }
  }

  _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 405:
        return 'Method Not Allowed';
      case 409:
        return 'Conflict';
      case 500:
        return 'Internal Server Error';
      case 502:
        return 'Bad Gateway';
      case 503:
        return 'Service Unavailable';
      default:
        return 'Something Went Wrong';
    }
  }
}
