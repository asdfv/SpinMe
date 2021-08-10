import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/localization/app_localization.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/widgets/message_bar.dart';

/// Show info message to the user.
extension ShowMessage on BuildContext {
  void info(String message) {
    MessageBar(this)..info(message);
  }

  void error(String message) {
    MessageBar(this)..error(message);
  }

  void success(String message) {
    MessageBar(this)..success(message);
  }
}

extension ContextExtension on BuildContext {
  /// Get localized string by [key].
  /// If [number] is set it will replace '%n' literal in the target string.
  String getLocalizedString(String key, [int? number]) {
    String string = AppLocalizations.of(this).getLocalizedString(key)!;
    if (number == null) return string;
    return string.replaceFirst(RegExp("%n"), number.toString());
  }
}
