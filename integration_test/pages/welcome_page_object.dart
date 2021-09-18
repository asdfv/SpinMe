import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WelcomePageObject {
  final WidgetTester _tester;
  final _letsGoButton = find.byKey(const ValueKey('lets_go_button'));
  final _welcomeTitleText = find.byKey(const ValueKey('welcome_title'));

  WelcomePageObject(this._tester);

  String? _getWelcomeMessage() {
    final welcomeTextWidget = _welcomeTitleText.evaluate().single.widget as Text;
    return welcomeTextWidget.data;
  }

  Future tapOnNext() async {
    await _tester.tap(_letsGoButton);
    await _tester.pumpAndSettle();
  }

  void checkWelcomeMessageIs(String message) {
    expect(_getWelcomeMessage(), equals("Welcome to SpinMe! Turn the wheel and do the task!"));
  }
}
