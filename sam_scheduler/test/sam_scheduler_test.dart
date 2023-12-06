import 'package:sam_scheduler/task_manager.dart';
import 'package:sam_scheduler/task.dart';
import 'package:test/test.dart';

void main() {
  group('TaskManager', () {
    test('Adding a task should increase the task count', () {
      final taskManager = TaskManager();
      final initialCount = taskManager.tasks.length;

      taskManager.addTask(Task('Sample Task', DateTime.now(), 1));

      expect(taskManager.tasks.length, initialCount + 1);
    });

    test('Removing a task should decrease the task count', () {
      final taskManager = TaskManager();
      final task = Task('Sample Task', DateTime.now(), 1);
      taskManager.addTask(task);
      final initialCount = taskManager.tasks.length;

      taskManager.removeTask(task);

      expect(taskManager.tasks.length, initialCount - 1);
    });

    test('Getting a task by index should return the correct task', () {
      final taskManager = TaskManager();
      final task = Task('Sample Task', DateTime.now(), 1);
      taskManager.addTask(task);

      final retrievedTask = taskManager.getTask(0);

      expect(retrievedTask, task);
    });

    test('Getting a task by description should return the correct task', () {
      final taskManager = TaskManager();
      final task = Task('Sample Task', DateTime.now(), 1);
      taskManager.addTask(task);

      final retrievedTask = taskManager.getTaskByDescription('Sample Task');

      expect(retrievedTask, task);
    });

    test('Getting tasks due today should return the correct tasks', () {
      final taskManager = TaskManager();
      final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      final task1 = Task('Sample Task 1', today, 1);
      final task2 = Task('Sample Task 2', today, 1);
      final task3 = Task('Sample Task 3', today, 1);
      taskManager.addTask(task1);
      taskManager.addTask(task2);
      taskManager.addTask(task3);

      final retrievedTasks = taskManager.getTaskDueToday();
      
      expect(retrievedTasks, [task1, task2, task3]);
    });

    test('Editing a task should update the task', () {
      final taskManager = TaskManager();
      final task = Task('Sample Task', DateTime.now(), 1);
      taskManager.addTask(task);

      taskManager.editTask(task, 'Edited Task', DateTime.now(), 2);

      expect(task.description, 'Edited Task');
      expect(task.priority, 2);
    });

    test('Sorting tasks should return the correct tasks', () {
      final taskManager = TaskManager();
      final today = DateTime.now();
      final task1 = Task('Sample Task 1', today, 1);
      final task2 = Task('Sample Task 2', today, 2);
      final task3 = Task('Sample Task 3', today, 3);
      taskManager.addTask(task3);
      taskManager.addTask(task1);
      taskManager.addTask(task2);

      final retrievedTasks = taskManager.sortTasks();

      expect(retrievedTasks, [task1, task2, task3]);
    });

    test('Sorting tasks by date should return the correct tasks', () {
      final taskManager = TaskManager();
      final today = DateTime.now();
      final task1 = Task('Sample Task 1', today, 1);
      final task2 = Task('Sample Task 2', today.add(Duration(days: 1)), 1);
      final task3 = Task('Sample Task 3', today.add(Duration(days: 2)), 1);
      taskManager.addTask(task3);
      taskManager.addTask(task1);
      taskManager.addTask(task2);

      final retrievedTasks = taskManager.sortTasksByDate();

      expect(retrievedTasks, [task1, task2, task3]);
    });

    test('Filtering tasks should return the correct tasks', () {
      final taskManager = TaskManager();
      final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      final task1 = Task('Sample Task 1', today, 1);
      final task2 = Task('Sample Task 2', today, 2);
      final task3 = Task('Sample Task 3', today, 3);
      taskManager.addTask(task3);
      taskManager.addTask(task1);
      taskManager.addTask(task2);

      final retrievedTasks = taskManager.filterTasks(2);

      expect(retrievedTasks, [task2]);
    });
  });
}
