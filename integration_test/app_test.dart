import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/main.dart' as app;

import 'pages/names_page_object.dart';
import 'pages/tasks_page_object.dart';
import 'pages/welcome_page_object.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Test positive flow', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      // Check welcome message
      final welcomePage = WelcomePageObject(tester);
      welcomePage.checkWelcomeMessageIs("Welcome to SpinMe! Turn the wheel and do the task!");
      await welcomePage.tapOnNext(); // Go to the choose players name page

      // Check adding player
      final namesPage = NamesPageObject(tester);
      await namesPage.tapAddName();
      const thirdPlayerName = "Jesebel_test";
      await namesPage.enterNameAndSubmit(thirdPlayerName);
      namesPage.checkNameExists(thirdPlayerName);
      await namesPage.navigateToChooseTasks();

      // Check add task
      final taskPage = TasksPageObject(tester);
      const testTask = "The best task that I can imagine!";
      taskPage.checkTaskNotExists(testTask);
      await taskPage.tapAddTask();
      await taskPage.enterNewTaskText(testTask);
      await taskPage.tapSubmitNewTask();
      taskPage.checkTaskExists(testTask);
    });
  });
}
