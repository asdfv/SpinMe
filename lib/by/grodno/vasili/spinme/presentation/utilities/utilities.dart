import 'package:flutter/material.dart';

extension SnackbarInScaffold on BuildContext {
  void snack(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}
