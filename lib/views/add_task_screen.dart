import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../view_models/task_provider.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  final Task? task;

  AddTaskScreen({this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final desc = _descController.text.trim();

                if (title.isEmpty || desc.isEmpty) return;

                final newTask = Task(
                  id: widget.task?.id,
                  title: title,
                  description: desc,
                  isCompleted: widget.task?.isCompleted ?? false,
                  createdAt: DateTime.now().toString(),
                );

                if (widget.task == null) {
                  ref.read(taskProvider.notifier).addTask(newTask);
                } else {
                  ref.read(taskProvider.notifier).updateTask(newTask);
                }

                Navigator.pop(context);
              },
              child: Text(widget.task == null ? 'Add Task' : 'Update Task'),
            )
          ],
        ),
      ),
    );
  }
}
