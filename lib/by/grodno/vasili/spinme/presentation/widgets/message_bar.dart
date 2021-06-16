import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MessageBar {
  final BuildContext context;

  MessageBar(this.context);

  info(String message) {
    showTopSnackBar(
      context,
      CustomSnackBar.info(
        message: message,
      ),
    );
  }

  success(String message) {
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: message,
      ),
    );
  }

  error(String message) {
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: message,
      ),
    );
  }
}
