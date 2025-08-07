import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

class MyToast {
  void showSuccess(String message) {
    toastification.show(
      title: Text(message),
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  void showWarning(String message) {
    toastification.show(
      title: Text(message),
      type: ToastificationType.warning,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  void showInfo(String message) {
    toastification.show(
      title: Text(message),
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  void showError(String message) {
    toastification.show(
      title: Text(message),
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
