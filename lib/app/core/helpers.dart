import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHelper {
  static void showSnackBar({
    required String title,
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 5),
  }) {
    // Todo : create my custom snackbar instead of getSnackbar
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red[100] : Colors.green[100],
      icon: Icon(
        isError ? Icons.error : Icons.check_circle,
        color: isError ? Colors.red[800] : Colors.green[800],
      ),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      colorText: isError ? Colors.red[800] : Colors.green[800],
      duration: duration,
    );
  }

  static void showLoadingDialog({String message = 'Loading...'}) {
    Get.dialog(
      AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(message),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
