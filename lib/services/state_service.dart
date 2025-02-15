import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateService<T> {
  T? _value;
  Rx<StatesData>? _status;
  Rx<StatesData> get status {
    return _status ??= StatesData.loading().obs;
  }

  T? get data => value;

  T? get value {
    return _value;
  }

  @protected
  set value(T? newValue) {
    if (_value == newValue) return;
    _value = newValue;
  }

  void change(T? newState, {StatesData? status}) {
    if (status != null) {
      _status?.value = status;
    }
    if (newState != _value) {
      _value = newState;
    }
  }
}

extension StateExt<T> on StateService<T> {
  Widget builder({
    required NotifierBuilder<T?> onSuccess,
    Widget Function(String? message, T? data)? onError,
    Widget? onLoading,
    Widget Function(String? message, T? data)? onEmpty,
  }) {
    return Obx(() {
      if (status.value.isLoading) {
        return onLoading ?? const Center(child: CircularProgressIndicator());
      } else if (status.value.isError) {
        return onError != null
            ? onError(status.value.errorMessage, data)
            : Center(child: Text('Terjadi kesalahan: ${status.value.errorMessage}'));
      } else if (status.value.isEmpty) {
        return onEmpty?.call(status.value.errorMessage, data) ?? const SizedBox.shrink();
      }
      return onSuccess(value);
    });
  }
}

class StatesData {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final bool isEmpty;
  final bool isLoadingMore;
  final String? errorMessage;

  StatesData._({
    this.isEmpty = false,
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.errorMessage,
    this.isLoadingMore = false,
  });

  factory StatesData.loading() {
    return StatesData._(isLoading: true);
  }

  factory StatesData.loadingMore() {
    return StatesData._(isSuccess: true, isLoadingMore: true);
  }

  factory StatesData.success() {
    return StatesData._(isSuccess: true);
  }

  factory StatesData.error([String? message]) {
    return StatesData._(isError: true, errorMessage: message);
  }

  factory StatesData.empty([String? message]) {
    return StatesData._(isEmpty: true, errorMessage: message);
  }
}
