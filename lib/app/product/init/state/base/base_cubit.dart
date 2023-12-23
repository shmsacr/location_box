import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

abstract class BaseCubit<T extends Object> extends Cubit<T> {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  BaseCubit(super.initialState);

  @override
  void emit(T state) {
    if (isClosed) return;
    try {
      _logger.d('Emitting state: $state');
      super.emit(state);
    } catch (e) {
      _logger.e(
        'Error emitting state ',
        error: e,
      );
    }
  }

  @override
  void onChange(Change<T> change) {
    super.onChange(change);
    _logger.d('State changed: $change');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    _logger.e('Error occurred in Cubit', error: error, stackTrace: stackTrace);
  }

  Future<void> safeCall(Future<void> Function() call) async {
    try {
      await call();
    } catch (e) {
      _logger.e('Error during async call', error: e);
    }
  }
}
