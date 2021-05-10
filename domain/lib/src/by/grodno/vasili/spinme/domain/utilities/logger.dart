import 'package:logger/logger.dart';

NotesLogger getLogger() {
  final logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 50,
        colors: true,
        printEmojis: true,
      ));
  return SimpleNotesLogger(logger);
}

abstract class NotesLogger {
  void v({required String message, Exception? error});

  void d({required String message, Exception? error});

  void i({required String message, Exception? error});

  void w({required String message, Exception? error});

  void e({required String message, Exception? error});
}

class SimpleNotesLogger extends NotesLogger {
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
