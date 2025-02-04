import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../view_models/task_provider.dart';
import '../view_models/theme_provider.dart';
import 'add_task_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks available'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title,
                      style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null)),
                  subtitle: Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          ref
                              .read(taskProvider.notifier)
                              .updateTask(task.copyWith(isCompleted: value!));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTaskScreen(task: task),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          ref.read(taskProvider.notifier).deleteTask(task.id!);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTaskScreen()),
        ),
      ),
    );
  }
}
