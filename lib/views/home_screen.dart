import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../view_models/task_provider.dart';
import '../view_models/theme_provider.dart';
import 'add_task_screen.dart';

final searchQueryProvider =
    StateProvider<String>((ref) => ''); // Search query state

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final tasks = ref.watch(taskProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final isTablet = MediaQuery.of(context).size.width > 600;

    final filteredTasks = tasks
        .where((task) =>
            task.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemBlue,
        title: Text(
          'Task Manager',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 12),
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _SearchBar(),
          Expanded(
            child: isTablet
                ? Row(
                    children: [
                      Expanded(
                          child:
                              TaskList(tasks: filteredTasks, isTablet: true)),
                      // Task List
                      Expanded(child: TaskDetailView()),
                      // Task Details View
                    ],
                  )
                : TaskList(tasks: filteredTasks, isTablet: false),
          ),
        ],
      ), // Mobile View with Actions
      floatingActionButton: FloatingActionButton(
        backgroundColor: CupertinoColors.activeBlue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTaskScreen()),
        ),
      ),
    );
  }
}

class _SearchBar extends ConsumerStatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<_SearchBar> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          focusNode: _focusNode,
          onChanged: (value) =>
              ref.read(searchQueryProvider.notifier).state = value,
          decoration: InputDecoration(
            hintText: "Search tasks...",
            prefixIcon: Icon(Icons.search),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
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
              return InkWell(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Text(
                          'Delete Task',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        content: Text('Do you want to delete this task?'),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Delete'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              ref
                                  .read(taskProvider.notifier)
                                  .deleteTask(task.id!);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTaskScreen(
                        task: task,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: CupertinoColors.systemGrey, width: 1),
                  ),
                  child: ListTile(
                    title: Text(
                      task.title,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    subtitle: Text(
                      task.description,
                      maxLines: 2,
                    ),
                    onTap: () {
                      // Handle task selection for tablet view
                    },
                  ),
                ),
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

/*margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: CupertinoColors.systemGrey, width: 1),
          ),*/
