// lib/dart_manager.dart

import 'task.dart';

class TaskManager {
    List<Task> tasks = [];

    void addTask(Task task) {
      tasks.add(task);
    }

    void removeTask(Task task) {
      tasks.remove(task);
    }

    Task getTask(int index) {
      return tasks[index];
    }

    Task getTaskByDescription(String description) {
      return tasks.firstWhere((task) => task.description == description);
    }

    List<Task> getTaskDueToday() {
      var today = DateTime.now();
      return tasks.where((task) => task.dueDate == today);
    }

    void printTasks() {
      for (var task in tasks) {
        print(task.description);
      }
    }

    void editTask(Task task, String description, DateTime dueDate, int priority) {
      task.description = description;
      task.dueDate = dueDate;
      task.priority = priority;
    }

    List<Task> sortTasks() {
        tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        return tasks;
    }

    void printSortedTasks() {
        sortTasks();
        printTasks();
    }

    List<Task> filterTasks(int priority) {
        var filteredTasks = tasks.where((task) => task.priority == priority);
        return filteredTasks.toList();
    }
}