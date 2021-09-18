import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class TasksPageObject {
  final WidgetTester _tester;
  final _addTaskButton = find.byKey(const ValueKey('tasks_widget_add_task_button'));
  final _dialogTextField = find.byKey(const ValueKey('text_dialog_text_field'));
  final _dialogConfirmButton = find.byKey(const ValueKey('text_dialog_ok_button'));

  TasksPageObject(this._tester);

  Future checkTaskExists(String text) async {
    expect(find.text(text), findsOneWidget);
  }

  Future checkTaskNotExists(String text) async {
    expect(find.text(text), findsNothing);
  }

  Future tapAddTask() async {
    await _tester.tap(_addTaskButton);
    await _tester.pumpAndSettle();
  }

  Future enterNewTaskText(String text) async {
    await _tester.enterText(_dialogTextField, text);
  }

  Future tapSubmitNewTask() async {
    await _tester.tap(_dialogConfirmButton);
    await _tester.pumpAndSettle();
  }
}
