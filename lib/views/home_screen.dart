import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../view_models/task_provider.dart';
import 'add_task_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final isTablet =
        MediaQuery.of(context).size.width > 600; // 📌 Check screen size

    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: isTablet
          ? Row(
              children: [
                Expanded(
                    child: TaskList(tasks: tasks, isTablet: true)), // Task List
                Expanded(child: TaskDetailView()), // Task Details View
              ],
            )
          : TaskList(tasks: tasks, isTablet: false), // Mobile View with Actions
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

class TaskList extends ConsumerWidget {
  // ✅ Use ConsumerWidget
  final List<Task> tasks;
  final bool isTablet;

  TaskList({required this.tasks, required this.isTablet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ Add WidgetRef
    return tasks.isEmpty
        ? Center(child: Text('No tasks available'))
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: isTablet
                    ? null
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddTaskScreen(task: task),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              ref
                                  .read(taskProvider.notifier)
                                  .deleteTask(task.id!); // ✅ Use ref.read()
                            },
                          ),
                        ],
                      ),
                onTap: () {
                  // Handle task selection for tablet view
                },
              );
            },
          );
  }
}

class TaskDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Select a task to view details'));
  }
}
