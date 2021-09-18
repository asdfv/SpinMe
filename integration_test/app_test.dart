import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('asd', (WidgetTester tr) async {

      // Start the app and check welcome message
      app.main();
      await tr.pump(const Duration(seconds: 1));
      await tr.pumpAndSettle();
      final letsGoButton = find.byKey(const ValueKey('lets_go_button'));
      expect(find.text("Welcome to SpinMe! Turn the wheel and do the task!"), findsOneWidget);

      // Go to the choose players name page
      await tr.tap(letsGoButton);
      await tr.pumpAndSettle();

      // Add third player (two are added by default after app installation)
      final addNameButton = find.byKey(const ValueKey('names_widget_add_name_button'));
      await tr.tap(addNameButton);
      await tr.pumpAndSettle();
      final nameField3 = find.byKey(const ValueKey('names_widget_name_field_3'));
      const thirdPlayerName = "Jesebel_test";
      await tr.enterText(nameField3, thirdPlayerName);
      await tr.pumpAndSettle();
      expect(find.text(thirdPlayerName), findsOneWidget);

      // Navigate to the next screen - Choose tasks
      final namesNextButton = find.byKey(const ValueKey('names_widget_next_button'));
      await tr.tap(namesNextButton);
      await tr.pumpAndSettle();

      // Add a task
      final addTaskButton = find.byKey(const ValueKey('tasks_widget_add_task_button'));
      await tr.tap(addTaskButton);
      await tr.pumpAndSettle();
      final dialogTextField = find.byKey(const ValueKey('text_dialog_text_field'));
      const testTask = "The best task that I can imagine!";
      await tr.enterText(dialogTextField, testTask);
      final dialogConfirmButton = find.byKey(const ValueKey('text_dialog_ok_button'));
      await tr.tap(dialogConfirmButton);
      await tr.pumpAndSettle();
      expect(find.text(testTask), findsOneWidget);
    });
  });
}
