import 'package:flutter/material.dart';

/// Show snackbar with message and OK button to quickly close it.
extension SnackbarInScaffold on BuildContext {
  void snack(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    ));
  }
}
