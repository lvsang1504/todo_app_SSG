import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/todo_list.dart';
import 'package:to_do_app/screens/tasks/tasks.dart';

void main() {
  testWidgets('Test Todolist widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Provider<TodoListModel>(
            create: (_) => TodoListModel(), child: Scaffold(body: Tasks()))));

    // Check title exists
    final titleFinder = find.text('TodoList');
    expect(titleFinder, findsOneWidget);

    // check input field to create new task exists
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    // find completed icon
    final completedIcon = find.byType(Icon);
    expect(completedIcon, findsOneWidget);
    await tester.tap(completedIcon);
    await tester.pumpAndSettle();
    final titleCompletedScreen = find.text('Completed Items');
    expect(titleCompletedScreen, findsOneWidget);
  });
}
