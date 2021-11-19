import 'package:logger/logger.dart';

SpinLogger? _logger;

/// Function to access to the logging in the app.
SpinLogger getLogger() {
  if (_logger == null) {
    final logger = Logger(
        printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ));
    _logger = SimpleNotesLogger(logger);
  }
  return _logger!;
}

/// Abstraction for logging in the app.
abstract class SpinLogger {
  void v({required String message, Exception? error});

  void d({required String message, Exception? error});

  void i({required String message, Exception? error});

  void w({required String message, Exception? error});

  void e({required String message, Exception? error});
}

/// [SpinLogger] implementation based on Flutter [Logger] package.
class SimpleNotesLogger extends SpinLogger {
  final Logger logger;

  SimpleNotesLogger(this.logger);

  @override
  void v({required String message, Exception? error}) {
    logger.v(message, error);
  }

  @override
  void d({required String message, Exception? error}) {
    logger.d(message, error);
  }

  @override
  void i({required String message, Exception? error}) {
    logger.i(message, error);
  }

  @override
  void e({required String message, Exception? error}) {
    logger.e(message, error);
  }

  @override
  void w({required String message, Exception? error}) {
    logger.w(message, error);
  }
}
