import 'package:flutter/material.dart';

/// The code snippet is defining a mixin called `LoadingMixin` that represents loading state
mixin LoadingMixin<T extends StatefulWidget> on State<T> {
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier<bool>(false);
/// The code snippet is defining a getter called `isLoading` that returns a boolean value
  bool get isLoading => _isLoadingNotifier.value;
/// The code snippet is defining a getter called `isLoadingNotifier` that returns a boolean value
  ValueNotifier<bool> get isLoadingNotifier => _isLoadingNotifier;
/// The code snippet is defining a method called `changeLoading` that returns a boolean value if user want to force give a bool value
  void changeLoading({bool? value}) {
    if (value != null) _isLoadingNotifier.value = value;
    _isLoadingNotifier.value = !_isLoadingNotifier.value;
  }
}
