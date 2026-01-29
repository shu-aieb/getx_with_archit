import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_with_archit/app/core/helpers.dart';
import 'package:getx_with_archit/app/data/models/user_model.dart';
import 'package:getx_with_archit/app/data/repository/user_repository.dart';

import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  final UserRepository _userRepository = UserRepository();

  // Reqctive Variable
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final response = await _userRepository.getUser();
      if (response.success) {
        users.assignAll(response.data!);
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
        AppHelper.showSnackBar(
          title: 'Error',
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'An Unexpected Error Occurred';
      AppHelper.showSnackBar(
        title: 'Error',
        message: errorMessage.value,
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Refreshing Users
  Future<void> refreshUsers() async {
    await fetchUsers();
  }

  Future<UserModel?> getUserById(int id) async {
    try {
      isLoading.value = true;
      final response = await _userRepository.getUserById(id);
      if (response.success && response.data != null) {
        return response.data;
      } else {
        AppHelper.showSnackBar(
          title: 'Error',
          message: 'Failed to fetch user details',
          isError: true,
        );
        return null;
      }
    } catch (e) {
      AppHelper.showSnackBar(
        title: 'Error',
        message: 'Failed to fetch user details',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<void> deleteUser(int id) async {
    try {
      isLoading.value = true;
      final response = await _userRepository.deleteUser(id);

      if (response.success) {
        users.removeWhere((user) => user.id == id);

        AppHelper.showSnackBar(
          title: 'Success',
          message: 'User Deleted Successfully',
          isError: false,
        );
      } else {
        AppHelper.showSnackBar(
          title: 'Error',
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      AppHelper.showSnackBar(
        title: 'Error',
        message: 'Failed to delete user',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
