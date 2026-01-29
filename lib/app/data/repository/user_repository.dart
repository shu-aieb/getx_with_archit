import 'package:dio/dio.dart';
import 'package:getx_with_archit/app/data/models/response_model.dart';
import 'package:getx_with_archit/app/data/models/user_model.dart';
import 'package:getx_with_archit/app/data/services/api_services.dart';

import '../../core/constants/api_constants.dart';

class UserRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  // Get all the Users
  Future<ApiResponse<List<UserModel>>> getUser() async {
    _cancelToken = CancelToken();
    final queryParameters = <String, dynamic>{};

    return await _apiServices.getList<UserModel>(
      ApiConstants.users,
      UserModel
          .fromJson, // can also be written as  : (data) => UserModel.fromJson(data)
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      cancelToken: _cancelToken,
    );
  }

  // Get User by Id
  Future<ApiResponse<UserModel>> getUserById(int id) async {
    _cancelToken = CancelToken();
    final queryParameters = <String, dynamic>{};

    return await _apiServices.get<UserModel>(
      '${ApiConstants.users}/$id',
      UserModel.fromJson,
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      cancelToken: _cancelToken,
    );
  }

  // Create a new user
  Future<ApiResponse<UserModel>> createUser(UserModel user) async {
    _cancelToken = CancelToken();
    return await _apiServices.post<UserModel>(
      ApiConstants.users,
      UserModel.fromJson,
      data: user.toJson(),
      cancelToken: _cancelToken,
    );
  }

  // Update User
  Future<ApiResponse<UserModel>> updateUser(UserModel user) async {
    _cancelToken = CancelToken();
    return await _apiServices.put<UserModel>(
      '${ApiConstants.users}/${user.id}',
      UserModel.fromJson,
      data: user.toJson(),
      cancelToken: _cancelToken,
    );
  }

  // Delete User
  Future<ApiResponse<bool>> deleteUser(int userId) async {
    _cancelToken = CancelToken();
    return await _apiServices.delete<bool>(
      '${ApiConstants.users}/$userId',
      (data) => true,
      cancelToken: _cancelToken,
    );
  }

  void cancelRequest() {
    _cancelToken?.cancel('Request canceled by the user');
  }
}
