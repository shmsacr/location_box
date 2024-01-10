import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin MountedMixin<T extends StatefulWidget> on State<T> {
  /// The code snippet is defining a getter called `mounted` that returns a boolean value
  Future<void> safeOperation(AsyncCallback callback) async {
    if (!mounted) return;
    callback();
  }
}
