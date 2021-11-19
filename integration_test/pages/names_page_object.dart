import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class NamesPageObject {
  final WidgetTester _tester;
  final _nameField3 = find.byKey(const ValueKey('names_widget_name_field_3'));
  final _addNameButton = find.byKey(const ValueKey('names_widget_add_name_button'));
  final _namesNextButton = find.byKey(const ValueKey('names_widget_next_button'));

  NamesPageObject(this._tester);

  Future tapAddName() async {
    await _tester.tap(_addNameButton);
    await _tester.pumpAndSettle();
  }

  Future enterNameAndSubmit(String name) async {
    await _tester.enterText(_nameField3, name);
    await _tester.pumpAndSettle();
  }

  checkNameExists(String name) async {
    expect(find.text(name), findsOneWidget);
  }

  Future navigateToChooseTasks() async {
    await _tester.tap(_namesNextButton);
    await _tester.pumpAndSettle();
  }
}
