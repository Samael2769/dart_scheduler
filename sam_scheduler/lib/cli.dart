// lib/cli.dart
import 'dart:io';
import 'task.dart';
import 'task_manager.dart';

void main(List<String> arguments) {
  final taskManager = TaskManager();

  while (true) {
    print('Enter a command: ');
    var command = stdin.readLineSync();

    if (command == 'quit') {
      break;
    } else if (command == 'add') {
      try {
        print('Enter task description: ');
        var description = stdin.readLineSync();
        print('Enter due date (yyyy-mm-dd): ');
        var dueDateInput = stdin.readLineSync();
        var dueDate = dueDateInput != null ? DateTime.parse(dueDateInput) : DateTime.now();
        print('Enter priority: ');
        var priorityInput = stdin.readLineSync();
        var priority = priorityInput != null ? int.parse(priorityInput) : 0;

        var task = Task(description ?? '', dueDate, priority);
        taskManager.addTask(task);
      } catch (e) {
        print('Error: Invalid input. Please try again.');
      }
    } else if (command == 'list') {
      taskManager.printTasks();
    } else if (command == 'sort') {
      taskManager.printSortedTasks();
    } else if (command == 'filter') {
      try {
        print('Enter priority: ');
        var priorityInput = stdin.readLineSync();
        var priority = priorityInput != null ? int.parse(priorityInput) : 0;
        var filteredTasks = taskManager.filterTasks(priority);
        for (var task in filteredTasks) {
          print(task.description);
        }
      } catch (e) {
        print('Error: Invalid input. Please try again.');
      }
    } else if (command == 'edit') {
      try {
        print('Enter task ID: ');
        var idInput = stdin.readLineSync();
        var id = idInput != null ? int.parse(idInput) : -1;
        var task = taskManager.getTask(id);
        if (task != null) {
          print('Enter new task description: ');
          var description = stdin.readLineSync() ?? '';
          print('Enter new due date (yyyy-mm-dd): ');
          var dueDateInput = stdin.readLineSync();
          var dueDate = dueDateInput != null ? DateTime.parse(dueDateInput) : DateTime.now();
          print('Enter new priority: ');
          var priorityInput = stdin.readLineSync();
          var priority = priorityInput != null ? int.parse(priorityInput) : 0;

          taskManager.editTask(task, description, dueDate, priority);
        } else {
          print('Error: Task not found.');
        }
      } catch (e) {
        print('Error: Invalid input. Please try again.');
      }
    } else if (command == 'remove') {
      try {
        print('Enter task ID: ');
        var idInput = stdin.readLineSync();
        var id = idInput != null ? int.parse(idInput) : -1;
        var task = taskManager.getTask(id);
        if (task != null) {
          taskManager.removeTask(task);
        } else {
          print('Error: Task not found.');
        }
      } catch (e) {
        print('Error: Invalid input. Please try again.');
      }
    } else {
      print('Error: Invalid command. Please try again.');
    }
  }
}