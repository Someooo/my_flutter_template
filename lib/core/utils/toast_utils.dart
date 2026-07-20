import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastUtils {
  // Show error snackbar
  static void showError(String error) {
    if (!_hasOverlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showError(error));
      return;
    }
    if (Get.isSnackbarOpen) {
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
    if (!_hasOverlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showSuccess(message));
      return;
    }
    if (Get.isSnackbarOpen) {
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

  static bool get _hasOverlay =>
      Get.overlayContext != null && Get.key.currentState?.overlay != null;

  // Connectivity snackbars
  static void showNoInternetSnackbar() {
    try {
      if (!_hasOverlay) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showNoInternetSnackbar();
        });
        return;
      }
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.rawSnackbar(
        message: 'Please check your internet connection.',
        backgroundColor: Colors.red.shade700,
        icon: const Icon(Icons.wifi_off_rounded, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        duration: const Duration(days: 1),
        isDismissible: false,
      );
    } catch (_) {
      // Safe fallback handled by ConnectivityBannerWidget
    }
  }

  static void showInternetRestoredSnackbar() {
    try {
      if (!_hasOverlay) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showInternetRestoredSnackbar();
        });
        return;
      }
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.rawSnackbar(
        message: 'Internet connection restored.',
        backgroundColor: Colors.green.shade700,
        icon: const Icon(Icons.wifi_rounded, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
        isDismissible: true,
      );
    } catch (_) {
      // Safe fallback
    }
  }

  static void dismissSnackbar() {
    try {
      if (!_hasOverlay) return;
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    } catch (_) {
      // Safe fallback
    }
  }
}


