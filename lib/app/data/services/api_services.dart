import 'package:dio/dio.dart';
import 'package:getx_with_archit/app/core/exception/network_exception.dart';
import 'package:getx_with_archit/app/data/models/response_model.dart';
import 'package:getx_with_archit/app/data/providers/api_provider.dart';

class ApiServices {
  final ApiProvider _apiProvider = ApiProvider();

  // generic method to handle API calls
  Future<ApiResponse<T>> handleAPICall<T>(
    Future<Response> Function() apiCall,
    T Function(dynamic data) fromJson,
  ) async {
    try {
      final response = await apiCall();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = fromJson(response.data);
        return ApiResponse.success(data);
      } else {
        return ApiResponse.error(
          'Request failed with status :  ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.message ?? 'Network error occurred',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Unexpected error : $e');
    }
  }

  // generic method to handle List API calls
  Future<ApiResponse<List<T>>> handleListAPICall<T>(
    Future<Response> Function() apiCall,
    T Function(dynamic data) fromJson,
  ) async {
    try {
      final response = await apiCall();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonList = response.data;
        final List<T> dataList = jsonList
            .map((json) => fromJson(json))
            .toList();
        return ApiResponse.success(dataList);
      } else {
        return ApiResponse.error(
          'Request failed with status :  ${response.statusCode}',
        );
      }
    } on NetworkException catch (e) {
      return ApiResponse.error(e.message);
    } catch (e) {
      return ApiResponse.error('Unexpected error : $e');
    }
  }

  //specific GET method
  Future<ApiResponse<T>> get<T>(
    String endPoint,
    T Function(dynamic data) fromJson, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return handleAPICall<T>(
      () => _apiProvider.get(
        endPoint,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      fromJson,
    );
  }

  //specific GET method
  Future<ApiResponse<List<T>>> getList<T>(
    String endPoint,
    T Function(dynamic data) fromJson, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return handleListAPICall<T>(
      () => _apiProvider.get(
        endPoint,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      fromJson,
    );
  }

  //specific POST method
  Future<ApiResponse<T>> post<T>(
    String endPoint,
    T Function(dynamic data) fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return handleAPICall<T>(
      () => _apiProvider.post(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      fromJson,
    );
  }

  //specific POST method
  Future<ApiResponse<T>> put<T>(
    String endPoint,
    T Function(dynamic data) fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return handleAPICall<T>(
      () => _apiProvider.put(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      fromJson,
    );
  }

  //specific DELETE method
  Future<ApiResponse<T>> delete<T>(
    String endPoint,
    T Function(dynamic data) fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return handleAPICall<T>(
      () => _apiProvider.delete(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      fromJson,
    );
  }
}
