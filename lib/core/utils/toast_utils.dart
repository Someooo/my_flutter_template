import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastUtils {
  // Show error snackbar
  static void showError(String error) {
    // Ensure that the controller is initialized before calling `closeAllSnackbars`
    if (Get.isSnackbarOpen) {
      // You can delay this action to allow the snackbar controller to be ready.
      Future.delayed(Duration.zero, () => Get.closeAllSnackbars());
    }
    Get.rawSnackbar(
      message: error.tr,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }

  // Show success snackbar
  static void showSuccess(String message) {
    if (Get.isSnackbarOpen) {
      // Same as above, make sure to close snackbars with a delay to ensure initialization
      Future.delayed(Duration.zero, () => Get.closeAllSnackbars());
    }
    Get.rawSnackbar(
      message: message.tr,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }

  // Show error snackbar with Get.snackbar format
  static void showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
    );
  }

  // Show success snackbar with Get.snackbar format
  static void showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
    );
  }

  // Show warning snackbar with Get.snackbar format
  static void showWarningSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
    );
  }
}
